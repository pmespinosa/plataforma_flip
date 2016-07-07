class AnswersController < ApplicationController
  before_action :set_question, :set_homework
  before_action :set_answer, only: [:edit, :destroy, :show, :update]
  before_filter :authenticate_user!
  # GET /answers
  # GET /answers.json
  def index
    @answer = current_user.answers.find_by_question_id(params[:question_id])
  end

  # GET /answer/1
  # GET /answer/1.json
  def show
    @answer = current_user.answers.find_by_question_id(params[:question_id])
  end

  # GET /answer/new
  def new
    @answer = Answer.new
  end

  # GET /answer/1/edit
  def edit
  end

  # POST /answer
  # POST /answer.json
  def create
    @answer = Answer.new(answer_params)
    current_user.answers << @answer
    @question.answers << @answer
    @answer.question = @question
    if @answer.save
      redirect_to homework_questions_path(@homework), notice: 'La respuesta ha sido enviada.'
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to homework_questions_path(@homework), notice: 'La respuesta ha sido actualizada.' }
        format.json { render :show, status: :ok, location: @homework }
      else
        format.html { render :edit }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to homework_questions_path(@homework), notice: 'La respuesta ha sido eliminada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_homework
      @homework = Homework.find(params[:homework_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:phase, :upload, :content)
    end

end
