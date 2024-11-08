class ProjectsController < ApplicationController
  def index
    @admin_user = User.find_by(admin: true)
    @projects = Project.order(created_at: :asc)
    @title = "Portfolio"
    @subtitle = "Conception, développement, déploiement : Un projet bien pensé."
    @resume = Resume.find_by(user: @admin_user)
    @contact = Contact.new
  end

  def show
    @admin_user = User.find_by(admin: true)
    @project = Project.find(params[:id])

    @title = @project.title
    @subtitle = @project.subtitle

    @frontend_technologies = @project.frontend_technologies.order(:order_position)
    @backend_technologies = @project.backend_technologies.order(:order_position)
    @tools = @project.tools.order(:order_position)

    @resume = Resume.find_by(user: @admin_user)
    @contact = Contact.new
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
