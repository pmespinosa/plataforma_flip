class AnswersController < ApplicationController
  before_action :set_homework
  before_action :set_answer, only: [:edit, :destroy, :show, :update]
  before_action :set_actividades_visible, only: :new
  before_action :set_breadcrumbs
  before_filter :authenticate_user!

  def index
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Realizar Actividad"]
    @partner = User.find_by_id(current_user.partner_id)
    @partner_answer = @partner.answers.find_by_homework_id(@homework.id)
    @answer = current_user.answers.find_by_homework_id(@homework.id)
  end

  def show
    answer = current_user.answers.find_by_homework_id(params[:homework_id])
    if @homework.actual_phase == "responder"
      @answer = answer.responder
    elsif @homework.actual_phase == "argumentar"
      @answer = answer.argumentar
    elsif @homework.actual_phase == "rehacer"
      @answer = answer.rehacer
    end
  end

  def new
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Realizar Actividad"]
    @answer = Answer.new
    @partner = User.find_by_id(current_user.partner_id)
    @partner_answer = @partner.answers.find_by_homework_id(@homework.id)
  end

  def edit
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Realizar Actividad"]
    @partner = User.find_by_id(current_user.partner_id)
    @partner_answer = @partner.answers.find_by_homework_id(@homework.id)
    @answer = current_user.answers.find_by_homework_id(@homework.id)
  end

  def create
    if @homework.upload
      @answer = Answer.new(answer_params)
      current_user.answers << @answer
      @homework.answers << @answer
      @answer.homework = @homework
    end
    if @answer.save
      redirect_to homework_answers_path(@homework)
    else
      render :new
    end
  end

  def update
    if @homework.upload
      respond_to do |format|
        @answer.update(answer_params)
        if @answer.save
          format.html { redirect_to homework_answers_path(@homework) }
          format.json { render :show, status: :ok, location: @homework }
        else
          format.html { render :edit }
          format.json { render json: @homework.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to homework_answers_path(@homework)
    end
  end

  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to homework_questions_path(@homework) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def set_homework
      @homework = Homework.find(params[:homework_id])
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

    def set_breadcrumbs
      @breadcrumbs = []
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:phase, :upload, :responder, :argumentar, :rehacer, :image_responder, :image_argumentar, :image_rehacer)
    end

end
