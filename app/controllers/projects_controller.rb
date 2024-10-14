class ProjectsController < ApplicationController
  def index
    @projects = Project.order(created_at: :asc)
    @title = "Portfolio"
    @subtitle = "Découvrez tous mes projets"
  end

  def show
    @project = Project.find(params[:id])

    @title = @project.title
    @subtitle = @project.subtitle
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
