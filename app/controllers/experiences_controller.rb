class ExperiencesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @resume = Resume.find(params[:resume_id])
    @experience = @resume.experiences.build

    @title = "Nouveau Job"
    @subtitle = "Félicitations pour cette nouvelle étape ! 💼"
  end

  def create
    @resume = Resume.find(params[:resume_id])
    @experience = @resume.experiences.build(experience_params)

    if @experience.save
      redirect_to about_path, notice: "Experience ajoutée avec succès"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @resume = Resume.find(params[:resume_id])
    @experience = @resume.experiences.find(params[:id])

    @title = "Modifier un Job"
    @subtitle = "Parce que chaque information compte. 📝"
  end

  def update
    @resume = Resume.find(params[:resume_id])
    @experience = @resume.experiences.find(params[:id])

    if @experience.update(experience_params)
      redirect_to about_path, notice: "Experience modifiée avec succès"
    else
      render :edit, status: :unprocessable
    end
  end

  def destroy
    @resume = Resume.find(params[:resume_id])
    @experience = @resume.experiences.find(params[:id])

    @experience.destroy

    redirect_to about_path, notice: "Experience supprimée avec succès"
  end

  private

  def experience_params
    params.require(:experience).permit(
      :job_title,
      :company_name,
      :location,
      :start_date,
      :end_date
    )
  end
end
