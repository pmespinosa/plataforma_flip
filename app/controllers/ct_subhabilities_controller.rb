class CtSubhabilitiesController < ApplicationController
  before_action :set_ct_subhability, only: [:show, :edit, :update, :destroy]

  # GET /ct_subhabilities
  # GET /ct_subhabilities.json
  def index
    @ct_subhabilities = CtSubhability.all
  end

  # GET /ct_subhabilities/1
  # GET /ct_subhabilities/1.json
  def show
  end

  # GET /ct_subhabilities/new
  def new
    @ct_subhability = CtSubhability.new
  end

  # GET /ct_subhabilities/1/edit
  def edit
  end

  # POST /ct_subhabilities
  # POST /ct_subhabilities.json
  def create
    @ct_subhability = CtSubhability.new(ct_subhability_params)

    respond_to do |format|
      if @ct_subhability.save
        format.html { redirect_to @ct_subhability, notice: 'Ct subhability was successfully created.' }
        format.json { render :show, status: :created, location: @ct_subhability }
      else
        format.html { render :new }
        format.json { render json: @ct_subhability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ct_subhabilities/1
  # PATCH/PUT /ct_subhabilities/1.json
  def update
    respond_to do |format|
      if @ct_subhability.update(ct_subhability_params)
        format.html { redirect_to @ct_subhability, notice: 'Ct subhability was successfully updated.' }
        format.json { render :show, status: :ok, location: @ct_subhability }
      else
        format.html { render :edit }
        format.json { render json: @ct_subhability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ct_subhabilities/1
  # DELETE /ct_subhabilities/1.json
  def destroy
    @ct_subhability.destroy
    respond_to do |format|
      format.html { redirect_to ct_subhabilities_url, notice: 'Ct subhability was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ct_subhability
      @ct_subhability = CtSubhability.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ct_subhability_params
      params.require(:ct_subhability).permit(:name, :description, :ct_hability_id)
    end
end
