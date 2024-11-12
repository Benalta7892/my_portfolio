class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about]
  before_action :ensure_admin!, except: %i[home about]

  def home
    @admin_user = User.find_by(admin: true)

    @frontend_technologies = TechnologyItem.where(category: "frontend").order(:order_position)
    @backend_technologies = TechnologyItem.where(category: "backend").order(:order_position)
    @tools = TechnologyItem.where(category: "tools").order(:order_position)

    @projects = Project.order(created_at: :asc)
    @contact = Contact.new
    @resume = Resume.find_by(user: @admin_user)
  end

  def about
    @admin_user = User.find_by(admin: true)
    @resume = Resume.find_by(user: @admin_user)
    @contact = Contact.new

    # Assurez-vous que ces variables sont bien initialisées
    @frontend_technologies = TechnologyItem.where(category: "frontend")
    @backend_technologies = TechnologyItem.where(category: "backend")
    @tools = TechnologyItem.where(category: "tools")

    return unless @resume

    @educations = @resume.educations.order(end_date: :desc)
    @experiences = @resume.experiences.order(end_date: :desc)

    @title = "Mon chemin"
    @subtitle = "La beauté d’une voie réside dans notre capacité à nous réinventer."
  end
end
