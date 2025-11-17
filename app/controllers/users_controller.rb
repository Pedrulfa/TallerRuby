class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    # role_id por defecto 
    @user.role_id ||= 4
    
    if @user.save
      redirect_to root_path, notice: "Usuario registrado correctamente"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
  end
end
