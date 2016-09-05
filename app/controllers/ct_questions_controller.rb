class CtQuestionsController < ApplicationController
  before_action :set_ct_question, only: [:show, :edit, :update, :destroy]

  # GET /ct_questions
  # GET /ct_questions.json
  def index
    @ct_questions = CtQuestion.all
  end

  # GET /ct_questions/1
  # GET /ct_questions/1.json
  def show
  end

  # GET /ct_questions/new
  def new
    @ct_question = CtQuestion.new
  end

  # GET /ct_questions/1/edit
  def edit
  end

  # POST /ct_questions
  # POST /ct_questions.json
  def create
    @ct_question = CtQuestion.new(ct_question_params)

    respond_to do |format|
      if @ct_question.save
        format.html { redirect_to @ct_question, notice: 'Ct question was successfully created.' }
        format.json { render :show, status: :created, location: @ct_question }
      else
        format.html { render :new }
        format.json { render json: @ct_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ct_questions/1
  # PATCH/PUT /ct_questions/1.json
  def update
    respond_to do |format|
      if @ct_question.update(ct_question_params)
        format.html { redirect_to @ct_question, notice: 'Ct question was successfully updated.' }
        format.json { render :show, status: :ok, location: @ct_question }
      else
        format.html { render :edit }
        format.json { render json: @ct_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ct_questions/1
  # DELETE /ct_questions/1.json
  def destroy
    @ct_question.destroy
    respond_to do |format|
      format.html { redirect_to ct_questions_url, notice: 'Ct question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ct_question
      @ct_question = CtQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ct_question_params
      params.require(:ct_question).permit(:id, :question, :tree_id)
    end
end
