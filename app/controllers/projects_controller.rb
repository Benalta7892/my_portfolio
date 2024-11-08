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
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      redirect_to projects_path, notice: "Projet créé avec succès."
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    # Récupération des fonctionnalités actuelles, des ajouts et suppressions
    features_to_delete = params[:project][:features_to_delete] || []
    new_features = Array(params[:project][:features]).reject(&:blank?) # Élimine les champs vides

    # Retire les fonctionnalités marquées pour suppression
    updated_features = @project.features - features_to_delete

    # Ajoute les nouvelles fonctionnalités restantes
    updated_features += new_features

    # Mise à jour des fonctionnalités
    if @project.update(project_params.merge(features: updated_features))
      redirect_to project_path(@project), notice: "Projet mis à jour avec succès."
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def project_params
    params.require(:project).permit(
      :title,
      :subtitle,
      :description,
      :link,
      :dev_count,
      features: [],
      pictures: [],
      frontend_technology_ids: [],
      backend_technology_ids: [],
      tool_ids: []
    )
  end
end
