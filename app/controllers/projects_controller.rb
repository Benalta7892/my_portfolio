class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :ensure_admin!, except: %i[index show]

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

    @title = "Nouveau projet"
    @subtitle = "Une nouvelle aventure. 🚀"
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      redirect_to @project, notice: "Projet créé avec succès."
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @project = Project.find(params[:id])

    @title = "Modifier un projet"
    @subtitle = "C'est toujours mieux quand c'est à jour. 🤓"
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
    @project = Project.find(params[:id])

    if @project.destroy
      redirect_to projects_path, notice: "Projet supprimé avec succès."
    else
      redirect_to projects_path, alert: "Impossible de supprimer le projet."
    end
  end

  private

  def project_params
    params.require(:project).permit(
      :title,
      :subtitle,
      :description,
      :link,
      :dev_count,
      :background_image,
      features: [],
      pictures: [],
      frontend_technology_ids: [],
      backend_technology_ids: [],
      tool_ids: []
    )
  end
end
