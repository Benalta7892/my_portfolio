class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  before_action :ensure_admin!, except: %i[new create]

  def index
  end

  def show
  end

  def new
    @contact = Contact.new
    @admin_user = User.find_by(admin: true)
    @title = "Contact"
    @subtitle = "Projets, idées, demandes ou collaborations – discutons-en !"
    @resume = Resume.find_by(user: @admin_user)
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_message(@contact).deliver_now
      flash[:notice] = "Merci pour votre message ! 📬 Je vous réponds au plus vite."
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
