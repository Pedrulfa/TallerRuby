class UsersController < ApplicationController
  
  before_action :require_login, only: [:show, :edit, :update, :index, :update_role]
  before_action :set_user, only: [:edit, :update]
  
  # Verificar permiso para gestionar usuarios
  before_action only: [:index, :update_role] do
    authorize_permission!("modify_role")
  end

  # Listado de usuarios (solo para quien tenga permiso modify_role)
  def index
    @users = User.includes(:role).all
  end

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

  # Nueva acción para modificar el rol de un usuario
  def update_role
    @user = User.find(params[:id])
    
    # Validar que no se intente modificar el rol de un ADMIN
    if @user.role.name == "ADMIN"
      redirect_to users_path, alert: "No se puede modificar el rol de un administrador"
      return
    end
    
    if @user.update(role_id: params[:role_id])
      redirect_to users_path, notice: "Rol actualizado correctamente"
    else
      redirect_to users_path, alert: "Error al actualizar el rol"
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