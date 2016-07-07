class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_homework

  # GET /questions
  # GET /questions.json
  def index
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
  def create
    @question = Question.new(question_params)
    @question2 = Question.new(phase:2, content:@question.content)
    @question3 = Question.new(phase:3, content:@question.content)
    @homework.questions << @question
    @homework.questions << @question2
    @homework.questions << @question3
    if @question.save && @question2.save && @question3.save
      redirect_to homework_questions_path(@homework), notice: 'La pregunta fue creada.'
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
        format.html { redirect_to homework_questions_path(@homework), notice: 'La pregunta fue actualizada.' }
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
    @question.destroy
    respond_to do |format|
      format.html { redirect_to [@homework,@question], notice: 'La pregunta fue removida.' }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:phase, :content, :anterior)
    end


end
