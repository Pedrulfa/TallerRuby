class UsersController < ApplicationController
  
  before_action :require_login, only: [:show, :edit, :update]
  
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    # role_id por defecto 
    @user.role_id ||= 4
    
    if @user.save
      redirect_to login_path, notice: "Usuario registrado correctamente"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show  # Muestra el perfil del usuario actual
    @user = current_user
  end

  def edit
  end

  def update
    # Elimina password y password_confirmation si están vacíos
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    
    if @user.update(user_update_params)
      redirect_to profile_path, notice: "Perfil actualizado exitosamente"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
  end

  # Parámetros permitidos al actualizar solo el admin puede modificar el role
  def user_update_params
    params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
  end

  # Carga el usuario actual
  def set_user
    @user = current_user
  end

  # Verifica que el usuario esté logueado
  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Debes iniciar sesión primero"
    end
  end
end
