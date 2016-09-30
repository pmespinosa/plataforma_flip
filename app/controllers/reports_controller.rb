class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :set_course, only: [:create, :new]
  before_action :set_miscursos_visible, only: [:show, :edit, :new]
  before_action :set_ef_visible, only: [:show, :edit]
  before_action :set_reporte_visible, only: [:show, :edit]
  before_action :set_actividades_visible, only: [:show, :edit]
  before_action :set_configuraciones_visible, only: [:show, :edit]
  before_action :set_breadcrumbs

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    total_trees_content = 0      
    total_trees_interpretation = 0
    total_trees_analysis = 0
    total_trees_evaluation = 0
    total_trees_inference = 0
    total_trees_explanation = 0
    total_trees_selfregulation = 0

    @report.trees.each do |tree|      
      tree.set_report_values
      
      if !tree.content_sc.nil?
        total_trees_content++
        if @report.content_sc.nil?
          @report.content_sc = 0
        end
        @report.content_sc += performance.content_sc
      end
      if !tree.interpretation_sc.nil?
        total_trees_interpretation++
        if @report.interpretation_sc.nil?
          @report.interpretation_sc = 0
        end
        @report.interpretation_sc += performance.interpretation_sc
      end
      if !tree.analysis_sc.nil?
        total_trees_analysis++
        if @report.analysis_sc.nil?
          @report.analysis_sc = 0
        end
       @report.analysis_sc += performance.analysis_sc
      end
      if !tree.evaluation_sc.nil?
        total_trees_evaluation++
        if @report.evaluation_sc.nil?
          @report.evaluation_sc = 0
        end
        @report.evaluation_sc += performance.evaluation_sc
      end
      if !tree.inference_sc.nil?
        total_trees_inference++
        if @report.inference_sc.nil?
          @report.inference_sc = 0
        end
        @report.inference_sc += performance.inference_sc
      end
      if !tree.explanation_sc.nil?
        total_trees_explanation++
        if @report.explanation_sc.nil?
          @report.explanation_sc = 0
        end
        @report.explanation_sc += performance.explanation_sc
      end
      if !tree.selfregulation_sc.nil?
        total_trees_selfregulation++
        if @report.selfregulation_sc.nil?
          @report.selfregulation_sc = 0
        end
        @report.selfregulation_sc += performance.selfregulation_sc
      end
    end

    if !@report.content_sc.nil?
      @report.content_sc = @report.content_sc/total_trees_content
    end
    if !@report.interpretation_sc.nil?
      @report.interpretation_sc = @report.interpretation_sc/total_trees_interpretation
    end
    if !@report.analysis_sc.nil?
       @report.analysis_sc = @report.analysis_sc/total_trees_analysis
    end
    if !@report.evaluation_sc.nil?
      @report.evaluation_sc = @report.evaluation_sc/total_trees_evaluation
    end
    if !@report.inference_sc.nil?
      @report.inference_sc = @tree.inference_sc/total_trees_inference
    end
    if  !@report.explanation_sc.nil?
      @report.explanation_sc = @report.explanation_sc/total_trees_explanation
    end
    if !@report.selfregulation_sc.nil?     
      @report.selfregulation_sc = @report.selfregulation_sc/total_trees_explanation
    end

    @report.save
    
  end

  # GET /reports/new
  def new
    @report = Report.new

    puts "new reporrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrt!"
    puts @report.inspect
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create

    puts "creandoooooooooooooooo el reporteeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    @report = @course.reports.new(report_params)

    respond_to do |format|
      if @report.save
          if params[:tree_ids]
            @course.trees.each do |tree|
              if params[:tree_ids][tree.id]
                @report.trees << Tree.find(params[:tree_ids][tree.id])
              end
            end
          end          
        format.html { redirect_to @course, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:id, :interpretation_sc, :analysis_sc, :evaluation_sc, :inference_sc, :explanation_sc,
      :selfregulation_sc, :name)
    end

    def set_course
      @course = Course.find(params[:course_id])
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
    def course_params
      params.require(:course).permit(:name, :description)
    end

    def set_breadcrumbs
      @breadcrumbs = []
    end
end