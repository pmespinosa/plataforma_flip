class CtChoicesController < ApplicationController
  before_action :set_ct_choice, only: [:show, :edit, :update, :destroy]

  # GET /ct_choices
  # GET /ct_choices.json
  def index
    @ct_choices = CtChoice.all
  end

  # GET /ct_choices/1
  # GET /ct_choices/1.json
  def show
  end

  # GET /ct_choices/new
  def new
    @ct_choice = CtChoice.new
  end

  # GET /ct_choices/1/edit
  def edit
  end

  # POST /ct_choices
  # POST /ct_choices.json
  def create
    @ct_choice = CtChoice.new(ct_choice_params)

    respond_to do |format|
      if @ct_choice.save
        format.html { redirect_to @ct_choice, notice: 'Ct choice was successfully created.' }
        format.json { render :show, status: :created, location: @ct_choice }
      else
        format.html { render :new }
        format.json { render json: @ct_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ct_choices/1
  # PATCH/PUT /ct_choices/1.json
  def update
    respond_to do |format|
      if @ct_choice.update(ct_choice_params)
        format.html { redirect_to @ct_choice, notice: 'Ct choice was successfully updated.' }
        format.json { render :show, status: :ok, location: @ct_choice }
      else
        format.html { render :edit }
        format.json { render json: @ct_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ct_choices/1
  # DELETE /ct_choices/1.json
  def destroy
    @ct_choice.destroy
    respond_to do |format|
      format.html { redirect_to ct_choices_url, notice: 'Ct choice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ct_choice
      @ct_choice = CtChoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ct_choice_params
      params.require(:ct_choice).permit(:text, :right, :ct_question_id)
    end
end
