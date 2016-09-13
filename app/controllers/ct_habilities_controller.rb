class CtHabilitiesController < ApplicationController
  before_action :set_ct_hability, only: [:show, :edit, :update, :destroy]

  # GET /ct_habilities
  # GET /ct_habilities.json
  def index
    @ct_habilities = CtHability.all
  end

  # GET /ct_habilities/1
  # GET /ct_habilities/1.json
  def show
  end

  # GET /ct_habilities/new
  def new
    @ct_hability = CtHability.new
  end

  # GET /ct_habilities/1/edit
  def edit
  end

  # POST /ct_habilities
  # POST /ct_habilities.json
  def create
    @ct_hability = CtHability.new(ct_hability_params)

    respond_to do |format|
      if @ct_hability.save
        format.html { redirect_to @ct_hability, notice: 'Ct hability was successfully created.' }
        format.json { render :show, status: :created, location: @ct_hability }
      else
        format.html { render :new }
        format.json { render json: @ct_hability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ct_habilities/1
  # PATCH/PUT /ct_habilities/1.json
  def update
    respond_to do |format|
      if @ct_hability.update(ct_hability_params)
        format.html { redirect_to @ct_hability, notice: 'Ct hability was successfully updated.' }
        format.json { render :show, status: :ok, location: @ct_hability }
      else
        format.html { render :edit }
        format.json { render json: @ct_hability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ct_habilities/1
  # DELETE /ct_habilities/1.json
  def destroy
    @ct_hability.destroy
    respond_to do |format|
      format.html { redirect_to ct_habilities_url, notice: 'Ct hability was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ct_hability
      @ct_hability = CtHability.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ct_hability_params
      params.require(:ct_hability).permit(:name, :description)
    end
end
