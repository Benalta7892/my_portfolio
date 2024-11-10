class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def ensure_admin!
    return if current_user&.admin?

    redirect_to root_path, alert: "Accès réservé à l'administrateur du site... moi ! 😅 "
  end

  # Redéfinition du message après connexion
  def after_sign_in_path_for(_resource)
    flash[:notice] = "Bienvenue, vous êtes connecté en tant qu'administrateur ! 🎉"
    root_path # Ou une autre page si vous souhaitez rediriger ailleurs
  end

  def after_sign_out_path_for(_resource_or_scope)
    flash[:notice] = "Vous avez été déconnecté. À bientôt ! 👋"
    root_path # Redirige vers la page d'accueil après la déconnexion
  end
end
