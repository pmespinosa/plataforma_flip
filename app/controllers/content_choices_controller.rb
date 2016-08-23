class ContentChoicesController < ApplicationController
  before_action :set_content_choice, only: [:show, :edit, :update, :destroy]

  # GET /content_choices
  # GET /content_choices.json
  def index
    @content_choices = ContentChoice.all
  end

  # GET /content_choices/1
  # GET /content_choices/1.json
  def show
  end

  # GET /content_choices/new
  def new
    @content_choice = ContentChoice.new
  end

  # GET /content_choices/1/edit
  def edit
  end

  # POST /content_choices
  # POST /content_choices.json
  def create
    @content_choice = ContentChoice.new(content_choice_params)

    respond_to do |format|
      if @content_choice.save
        format.html { redirect_to @content_choice, notice: 'Content choice was successfully created.' }
        format.json { render :show, status: :created, location: @content_choice }
      else
        format.html { render :new }
        format.json { render json: @content_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /content_choices/1
  # PATCH/PUT /content_choices/1.json
  def update
    respond_to do |format|
      if @content_choice.update(content_choice_params)
        format.html { redirect_to @content_choice, notice: 'Content choice was successfully updated.' }
        format.json { render :show, status: :ok, location: @content_choice }
      else
        format.html { render :edit }
        format.json { render json: @content_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /content_choices/1
  # DELETE /content_choices/1.json
  def destroy
    @content_choice.destroy
    respond_to do |format|
      format.html { redirect_to content_choices_url, notice: 'Content choice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_choice
      @content_choice = ContentChoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_choice_params
      params.require(:content_choice).permit(:text, :right, :content_question_id)
    end
end
