class ContentQuestionsController < ApplicationController
  before_action :set_content_question, only: [:show, :edit, :update, :destroy]

  # GET /content_questions
  # GET /content_questions.json
  def index
    @content_questions = ContentQuestion.all
  end

  # GET /content_questions/1
  # GET /content_questions/1.json
  def show
  end

  # GET /content_questions/new
  def new
    @content_question = ContentQuestion.new
  end

  # GET /content_questions/1/edit
  def edit
  end

  # POST /content_questions
  # POST /content_questions.json
  def create
    @content_question = ContentQuestion.new(content_question_params)

    respond_to do |format|
      if @content_question.save
        format.html { redirect_to @content_question, notice: 'Content question was successfully created.' }
        format.json { render :show, status: :created, location: @content_question }
      else
        format.html { render :new }
        format.json { render json: @content_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /content_questions/1
  # PATCH/PUT /content_questions/1.json
  def update
    respond_to do |format|
      if @content_question.update(content_question_params)
        format.html { redirect_to @content_question, notice: 'Content question was successfully updated.' }
        format.json { render :show, status: :ok, location: @content_question }
      else
        format.html { render :edit }
        format.json { render json: @content_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /content_questions/1
  # DELETE /content_questions/1.json
  def destroy
    @content_question.destroy
    respond_to do |format|
      format.html { redirect_to content_questions_url, notice: 'Content question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_question
      @content_question = ContentQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_question_params
      params.require(:content_question).permit(:question, :tree_id)
    end
end
