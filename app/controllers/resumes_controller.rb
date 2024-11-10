class ResumesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[download_resume]
  before_action :ensure_admin!, except: %i[download_resume]

  def index
  end

  def show
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

  def download_resume
    @resume = Resume.find(params[:id]) # Assurez-vous que l'ID du CV est passé
    if @resume.pdf.attached?
      # Utilisez `@resume.pdf` pour obtenir le fichier si vous utilisez ActiveStorage
      send_data @resume.pdf.download, filename: "BenoitAlexandreCV.pdf", type: 'application/pdf', disposition: 'inline'
    else
      redirect_to root_path, alert: "Le CV n'est pas disponible."
    end
  end
end
