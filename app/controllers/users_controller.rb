class UsersController < ApplicationController
  before_action :set_users

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless current_user.profesor?
      unless @user == current_user
        redirect_to :back, :alert => "Acceso no permitido."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "Usuario actualizado."
    else
      redirect_to users_path, :alert => "No es posible actualizar el usuario."
    end
  end


  def asistencia

  end  

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "Usuario eliminado."
  end

  private

  def admin_only
    unless current_user.profesor?
      redirect_to :back, :alert => "Acceso no permitido."
    end
  end

  def secure_params
    params.require(:user).permit(:role)
  end

  def set_users
      @users = User.all
  end

  def user_params
      params.require(:user).permit(:asistencia, :partner_id)
    end
end
