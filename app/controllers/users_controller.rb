class UsersController < ApplicationController
  before_action :set_users
  before_action :set_courses

  def index
    @users = User.all
    current_user.current_course_id = nil
    current_user.save
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
    libres = []
    if params["asistentes"] != nil
      params["asistentes"].each do |p|
        asistente = User.find_by_id(p[0])
        asistente.partner_id = nil
        asistente.asistencia = p[1]['asistencia']
        if asistente.asistencia
          libres.append(asistente)
        end
        asistente.save
      end
      if libres.length > 1
        if libres.length % 2 != 0
          while true do
            i1 = rand(libres.length)
            i2 = rand(libres.length)
            i3 = rand(libres.length)
            if i1 != i2 && i1 != i3 && i2 != i3
              orden = [i1, i2, i3].sort
              break
            end
          end
          p1 = libres[i1]
          p2 = libres[i2]
          p3 = libres[i3]
          p1.partner_id = p2.id
          p2.partner_id = p3.id
          p3.partner_id = p1.id
          p1.save
          p2.save
          p3.save
          libres.delete_at(orden.pop)
          libres.delete_at(orden.pop)
          libres.delete_at(orden.pop)
        end
        for i in 1..(libres.length/2)
          i1 = rand(libres.length)
          p1 = libres[i1]
          i2 = rand(libres.length)
          while i2 == i1 do
            i2 = rand(libres.length)
          end
          p2 = libres[i2]
          p1.partner_id = p2.id
          p2.partner_id = p1.id
          p1.save
          p2.save
          if i1 > i2
            libres.delete_at(i1)
            libres.delete_at(i2)
          else
            libres.delete_at(i2)
            libres.delete_at(i1)
          end
        end
        redirect_to users_path, :notice => "Lista actualizada."
      end
    end
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
