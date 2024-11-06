class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @admin_user = User.find_by(admin: true)
    @projects = Project.order(created_at: :asc)
    @contact = Contact.new
    @resume = Resume.find_by(user: @admin_user)
  end

  def about
    @admin_user = User.find_by(admin: true)
    @resume = Resume.find_by(user: @admin_user)
    @contact = Contact.new

    return unless @resume

    @educations = @resume.educations.order(order_position: :asc)
    @experiences = @resume.experiences.order(order_position: :asc)

    @title = "Mon chemin"
    @subtitle = "Tourné vers l'appel du developpement web, vers une passion."
  end
end
