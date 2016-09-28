class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_homework
  before_action :set_actividades_visible, only: :index

  # GET /questions
  # GET /questions.json
  def index
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Realizar Actividad"]
    @questions = @homework.questions
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @answer = current_user.answers.find_by_question_id(params[:id])
  end

  # GET /questions/new
  def new
    @question = Question.new
    @question2 = Question.new
    @question3 = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create homework
    @question = Question.new(phase:0, content: homework.content)
    @question2 = Question.new(phase:1, content:homework.content)
    @question3 = Question.new(phase:2, content:homework.content)
    homework.questions << @question
    homework.questions << @question2
    homework.questions << @question3
    homework.save
    if @question.save && @question2.save && @question3.save
      @question2.anterior = @question.id
      @question3.anterior = @question2.id
      @question2.save
      @question3.save
    else
      render :new
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to homework_questions_path(@homework) }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    auxiliar = @question
    while true do
      if auxiliar.anterior == nil
        break
      end
      auxiliar = Question.find_by_id(auxiliar.anterior)
    end
    siguiente = Question.find_by_id(auxiliar.id + 1)
    siguiente2 = Question.find_by_id(siguiente.id + 1)
    auxiliar.destroy
    siguiente.destroy
    siguiente2.destroy
    respond_to do |format|
      format.html { redirect_to [@homework,@question] }
      format.json { render :show, status: :ok, location: @question }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
      @question2 = Question.find(params[:id])
      @question3 = Question.find(params[:id])
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:phase, :content, :anterior)
    end


end