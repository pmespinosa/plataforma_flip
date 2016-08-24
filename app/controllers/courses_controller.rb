class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @course = Course.find(params[:id])
    @courses = Course.all
  end

  def students
    @users = User.all
  end

  def configuration
    if params["roles"] != nil
      params["roles"].each do |p|
        user = User.find_by_id(p[0])
        user.role = p[1]["role"]
        user.save
      end
      redirect_to users_path, :notice => "Cambios guardados."
    end
    @users = User.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @courses = Course.all
    current_user.current_course_id = @course.id
    current_user.save
  end

  def new
    @course = Course.new
  end

  # GET /homeworks/1/edit
  def edit
    if params["roles"] != nil
      params["roles"].each do |p|
        user = User.find_by_id(p[0])
        user.role = p[1]["role"]
        user.save
      end
      redirect_to course_path(current_user.current_course_id), :notice => "Cambios guardados."
    end
    @users = User.all
  end

  # POST /homeworks
  # POST /homeworks.json
  def create
    @course = Course.new(course_params)
    @course.users << current_user
    current_user.courses << @course

    respond_to do |format|
      if @course.save
        format.html { redirect_to users_path, notice: 'El curso ha sido creado.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
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
