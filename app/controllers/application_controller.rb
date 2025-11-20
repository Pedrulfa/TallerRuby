class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  helper_method :current_user, :logged_in?, :can?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  # Helper para verificar permisos en vistas y controladores
  def can?(permission_name)
    logged_in? && current_user.can?(permission_name)
  end

  # Método para requerir un permiso específico (usar en before_action)
  def authorize_permission!(permission_name)
    unless can?(permission_name)
      redirect_to root_path, alert: "No tienes permiso para realizar esta acción"
    end
  end

  # Método para requerir que el usuario esté logueado
  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Debes iniciar sesión primero"
    end
  end

end
