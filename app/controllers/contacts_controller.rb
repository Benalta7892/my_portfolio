class ContactsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_message(@contact).deliver_now
      flash[:notice] = "Votre message a été envoyé avec succès."
      redirect_to root_path
    else
      flash[:alert] = "Votre message n'a pas pu être envoyé."
      render :new
    end
  end

  def destroy
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :subject, :message)
  end
end
