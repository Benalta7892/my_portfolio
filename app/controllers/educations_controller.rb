class EducationsController < ApplicationController
  before_action :ensure_admin!
  def index
  end

  def show
  end

  def new
    @resume = Resume.find(params[:resume_id])
    @education = @resume.educations.build

    @title = "Nouveau diplôme"
    @subtitle = "Felicitations pour cette nouvelle étape ! 🎓"
  end

  def create
    @resume = Resume.find(params[:resume_id])
    @education = @resume.educations.build(education_params)

    if @education.save
      redirect_to about_path, notice: "Education ajoutée avec succès"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @resume = Resume.find(params[:resume_id])
    @education = @resume.educations.find(params[:id])

    @title = "Modifier un Diplôme"
    @subtitle = "Parce que chaque information compte. 📚"
  end

  def update
    @resume = Resume.find(params[:resume_id])
    @education = @resume.educations.find(params[:id])

    if @education.update(education_params)
      redirect_to about_path, notice: "Education modifiée avec succès"
    else
      render :edit, status: :unprocessable
    end
  end

  def destroy
    @resume = Resume.find(params[:resume_id])
    @education = @resume.educations.find(params[:id])

    @education.destroy

    redirect_to about_path, notice: "Education supprimée avec succès"
  end

  private

  def education_params
    params.require(:education).permit(
      :diploma_name,
      :institution_name,
      :location,
      :start_date,
      :end_date
    )
  end
end
