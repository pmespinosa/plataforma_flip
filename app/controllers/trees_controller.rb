class TreesController < ApplicationController
  before_action :set_tree, only: [:show, :edit, :update, :destroy]
   before_action :set_course, only: [:create, :new]

  # GET /trees
  # GET /trees.json
  def index
    @trees = Tree.all
  end

  # GET /trees/1
  # GET /trees/1.json
  def show

    #@initial_content_question = @tree.content_questions.find_by header: "initial_content_question"

    #puts "holes"
    #puts @initial_content_question.inspect

    #@initial_ct_question = @tree.ct_questions.find_by header: "initial_ct_question"

    #@recuperative_content_question = @tree.content_questions.find_by header: "recuperative_content_question"

    #@recuperative_ct_question = @tree.ct_questions.find_by header: "recuperative_ct_question"

    #@deeping_content_question = @tree.content_questions.find_by header: "deeping_content_question"

    #@deeping_ct_question = @tree.ct_questions.find_by header: "deeping_ct_question"

    #@initial_simple_feedback = @tree.feedbacks.build
    #@initial_complex_feedback = @tree.feedbacks.build
    #@recuperative_simple_feedback = @tree.feedbacks.build
    #@recuperative_complex_feedback = @tree.feedbacks.build
    #@deeping_simple_feedback = @tree.feedbacks.build
    #@deeping_complex_feedback = @tree.feedbacks.build
  end

  # GET /trees/new
  def new
    
    @tree = Tree.new
  
    #@course = Course.find(:course_id)
    puts "aca-----------"
    #puts @course.inspect
    #@tree = @course.trees.new
    #@tree = @course.trees.build
    #respond_with(@tree)
   
    @tree.build_content
    
    #@initial_content_question = @tree.content_questions.build(:header => "initial_content_question")
    @tree.build_initial_content_question
    4.times { @tree.initial_content_question.content_choices.build }

    #@initial_ct_question = @tree.ct_questions.build(:header => "initial_ct_question")
    @tree.build_initial_ct_question
    4.times { @tree.initial_ct_question.ct_choices.build }

    #@recuperative_content_question = @tree.content_questions.build(:header => "recuperative_content_question")
    @tree.build_recuperative_content_question
    4.times { @tree.recuperative_content_question.content_choices.build }

    #@recuperative_ct_question = @tree.ct_questions.build(:header => "recuperative_ct_question")
    @tree.build_recuperative_ct_question
    4.times { @tree.recuperative_ct_question.ct_choices.build }

    #@deeping_content_question = @tree.content_questions.build(:header => "deeping_content_question")
    @tree.build_deeping_content_question
    4.times { @tree.deeping_content_question.content_choices.build }

    #@deeping_ct_question = @tree.ct_questions.build(:header => "deeping_ct_question")
    @tree.build_deeping_ct_question
    4.times { @tree.deeping_ct_question.ct_choices.build }

    @initial_simple_feedback = @tree.feedbacks.build
    @initial_complex_feedback = @tree.feedbacks.build
    @recuperative_simple_feedback = @tree.feedbacks.build
    @recuperative_complex_feedback = @tree.feedbacks.build
    @deeping_simple_feedback = @tree.feedbacks.build
    @deeping_complex_feedback = @tree.feedbacks.build

  end

  # GET /trees/1/edit
  def edit
    @tree.build_content if @tree.content.nil?
    @tree.build_initial_content_question if @tree.initial_content_question.nil?
    @tree.build_initial_ct_question if @tree.initial_ct_question.nil?
    @tree.build_recuperative_content_question if @tree.recuperative_content_question.nil?  
    @tree.build_recuperative_ct_question if @tree.recuperative_ct_question.nil?  
    @tree.build_deeping_content_question if @tree.deeping_content_question.nil?
    @tree.build_deeping_ct_question if @tree.deeping_content_question.nil?
  
  
  end

  # POST /trees
  # POST /trees.json
  def create
    #@tree = Tree.new(tree_params)
    #@course = Course.find(:course_id)
    @tree = @course.trees.new(tree_params)

    respond_to do |format|
      if @tree.save
        puts "acaa si------"
        #puts :course_id
        format.html { redirect_to @course, notice: 'Tree was successfully created.' }
        format.json { render :show, status: :created, location: @tree }
      else
        format.html { render :new }
        format.json { render json: @tree.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trees/1
  # PATCH/PUT /trees/1.json
  def update
    @tree = @course.trees.new(tree_params)

    respond_to do |format|
      if @tree.update(tree_params)
        format.html { redirect_to @course, notice: 'Tree was successfully updated.' }
        format.json { render :show, status: :ok, location: @tree }
      else
        format.html { render :edit }
        format.json { render json: @tree.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trees/1
  # DELETE /trees/1.json
  def destroy
    @tree.destroy
    respond_to do |format|
      format.html { redirect_to trees_url, notice: 'Tree was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tree
      @course = Course.find(params[:course_id])
      @tree = @course.trees.find(params[:id])
     
    end

    def set_course
      @course = Course.find(params[:course_id])
     
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tree_params
      params.require(:tree).permit(:video, content_attributes: [:text], 
        initial_content_question_attributes: [:question],
        initial_ct_question_attributes: [:question],
        recuperative_content_question_attributes: [:question],
        recuperative_ct_question_attributes: [:question],
        deeping_content_question_attributes: [:question],
        deeping_ct_question_attributes: [:question])

    end
    def ct_question_params
      params.require(:tree).permit(:header, :question, :tree_id)
    end
    def content_question_params
      params.require(:tree).permit(:header, :question, :tree_id)
    end
end
