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
    r = Random.new
    asignados = []
    libres = []
    if params["asistentes"] != nil
      params["asistentes"].each do |p|
        asistente = User.find_by_id(p[0])
        asistente.asistencia = p[1]['asistencia']
        if asistente.asistencia
          libres.append(asistente)
        end
        asistente.save
      end
      aux = libres
      if libres.length % 2 == 0
        for i in 0..libres.length
          p = libres[i]
          if aux.include?(p)
            partner = aux[r.rand(aux.length)]
            while partner == p do
              partner = aux[r.rand(aux.length)]
            end
            p.partner_id = partner.id
            p.save
            aux.delete(partner)
            asignados.append(partner)
            puts p.partner_id
            puts "esto es"
          end
        end
      else
        puts false
      end
      params["asistentes"].each do |p|
        asistente = User.find_by_id(p[0])
        puts asistente.id
        puts asistente.partner_id
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

  def user_params
      params.require(:user).permit(:asistencia, :partner_id)
    end
end
