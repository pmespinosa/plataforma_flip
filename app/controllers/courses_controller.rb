class CoursesController < ApplicationController
  before_action :set_course, only: [:asistencia, :students, :show, :edit, :update, :destroy]

  def index
    @course = Course.find(params[:id])
    @courses = Course.all
  end

  def show
    @courses = Course.all
    current_user.current_course_id = @course.id
    current_user.save
    if !current_user.role?
      redirect_to homeworks_path
    end
  end

  def new
    @course = Course.new
  end

  def edit
    @course = Course.find(params[:id])
    if params["roles"] != nil
      params["roles"].each do |p|
        user = User.find_by_id(p[0])
        user.role = p[1]["role"]
        user.save
      end
      redirect_to course_path(current_user.current_course_id)
    end
    @users = @course.users
  end

  def agregate
    course = Course.all.where(course_code: params["new_code_course"]["course_code"])[0]
    if course
      if !current_user.courses.find_by_id(course.id)
        current_user.courses << course
        current_user.save
      end
    end
    redirect_to users_path
  end

  def create
    @course = Course.new(course_params)
    respond_to do |format|
      if @course.save
        @course.course_code = (current_user.id.to_s + @course.id.to_s).to_i
        if @course.save
          format.html { redirect_to users_path}
          format.json { render :show, status: :created, location: @course }
        else
          format.html { render :new }
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
    current_user.courses << @course
    current_user.save
  end

  def students
    @users = @course.users
  end

  def asistencia homework
    @users = @course.users
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
        redirect_to homework_path(homework)
        #redirect_to course_path(current_user.current_course_id)
      end
    end
  end

  def update
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :description)
    end
end
