class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def ensure_admin!
    return if current_user&.admin?

    redirect_to root_path, alert: "Accès réservé à l'administrateur du site... moi ! 😅 "
  end
end
