class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  # before_action agregar que pida usuario gem device

  def index
    @course = Course.find(params[:id])
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @courses = Course.all
    @username = params['lis_person_sourcedid']
  end
  def new
    @course = Course.new
  end

  # GET /homeworks/1/edit
  def edit
  end

  # POST /homeworks
  # POST /homeworks.json
  def create
    @course = Course.new(course_params)

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
