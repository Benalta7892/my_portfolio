class ContactsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @contact = Contact.new

    @title = "Contactez-moi"
    @subtitle = "Contactez-moi pour toute demande ou collaboration."
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
    params.require(:contact).permit(:last_name, :email, :message)
  end
end
