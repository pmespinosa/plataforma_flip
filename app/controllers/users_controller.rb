class UsersController < ApplicationController
  before_action :set_users
  before_action :set_courses

  def index
    current_user.current_course_id = 11111 # CAMBIE NIL => numero para que no se caiga cuando activa o desactiva navbar
    current_user.save
  end

  def show
    @user = User.find(params[:id])
    unless current_user.profesor?
      unless @user == current_user
        redirect_to :back
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path
    else
      redirect_to users_path
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path
  end

  private

  def admin_only
    unless current_user.profesor?
      redirect_to :back
    end
  end

  def secure_params
    params.require(:user).permit(:role)
  end

  def set_asistente
    @asistente = User.find(params[:id])
  end

  def set_users
    @users = User.all
  end

  def set_courses
    @courses = current_user.courses
  end

  def user_params
      params.require(:user).permit(:asistencia, :partner_id)
  end
end
