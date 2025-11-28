class SessionsController < ApplicationController
  def new
    # solo muestra el formulario
  end

  def create
    user = User.find_by(email: params[:email].downcase)

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Sesión iniciada correctamente"
    else
      flash.now[:alert] = "Email o contraseña incorrectos"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Sesión cerrada"
  end
end
