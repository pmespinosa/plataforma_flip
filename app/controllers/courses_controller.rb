class CoursesController < ApplicationController

  before_action :set_course, only: [:asistencia, :students, :show, :edit, :update, :destroy, :eval_form]
  before_action :set_miscursos_visible, only: [:show, :eval_form]
  before_action :set_ef_visible, only: [:show, :eval_form]
  before_action :set_actividades_visible, only: [:show, :eval_form]
  before_action :set_configuraciones_visible, only: [:show, :eval_form]
  before_action :set_breadcrumbs


  def index
    @course = Course.find(params[:id])
    @courses = Course.all
  end

  def show
    @breadcrumbs = ["Mis Cursos", @course.name]
    @courses = Course.all
    current_user.current_course_id = @course.id
    current_user.save
    if !current_user.role?
      redirect_to homeworks_path
    end
  end

  def new
    @breadcrumbs = ["Mis Cursos", "Crear Curso"]
    @course = Course.new
  end

  def edit
    @breadcrumbs = ["Mis Cursos", @course.name, "Configuraciones"]
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

  def eval_form
    @breadcrumbs = ["Mis Cursos", @course.name, "Evaluación Formativa"]
    render "eval_form"
  end

  def students
    @users = @course.users
  end

  def remove_from_course
    puts 'Estoy pasando por el met'
    user = User.all.where(id:params['id'])[0]
    objt = UserCourse.all.where(user_id: user.id)
    puts objt
    puts "esto es obj"
    course = Course.find(current_user.current_course_id)
    user.courses.destroy(course)
    user.save
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

    def set_miscursos_visible
      @miscursos_visible = true
    end

    def set_ef_visible
      @ef_visible = true
    end

    def set_reporte_visible
      @reporte_visible = true
    end

    def set_actividades_visible
      @actividades_visible = true
    end

    def set_configuraciones_visible
      @Configuraciones_visible = true
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :description)
    end

    def set_breadcrumbs
      @breadcrumbs = []
    end
end
