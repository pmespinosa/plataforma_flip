class TreesController < ApplicationController
  before_action :set_tree, only: [:show, :edit, :update, :destroy]

  # GET /trees
  # GET /trees.json
  def index
    @trees = Tree.all
  end

  # GET /trees/1
  # GET /trees/1.json
  def show
  end

  # GET /trees/new
  def new
    @tree = Tree.new
    @tree.build_content

    @initial_content_question = @tree.content_questions.build
    4.times { @initial_content_question.content_choices.build }

    @initial_ct_question = @tree.ct_questions.build
    4.times { @initial_ct_question.ct_choices.build }

    @recuperative_content_question = @tree.content_questions.build
    4.times { @recuperative_content_question.content_choices.build }

    @recuperative_ct_question = @tree.ct_questions.build
    4.times { @recuperative_ct_question.ct_choices.build }

    @deeping_content_question = @tree.content_questions.build
    4.times { @deeping_content_question.content_choices.build }

    @deeping_ct_question = @tree.ct_questions.build
    4.times { @deeping_ct_question.ct_choices.build }

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
  end

  # POST /trees
  # POST /trees.json
  def create
    @tree = Tree.new(tree_params)    

    respond_to do |format|
      if @tree.save
        format.html { redirect_to @tree, notice: 'Tree was successfully created.' }
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
    respond_to do |format|
      if @tree.update(tree_params)
        format.html { redirect_to @tree, notice: 'Tree was successfully updated.' }
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
      @tree = Tree.find(params[:id])
     
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tree_params
      params.require(:tree).permit(:video, :tree_id, content_attributes: [:text])
    end
    def ct_question_params
      params.require(:tree).permit(:question, :tree_id)
    end
    def content_question_params
      params.require(:tree).permit(:question, :tree_id)
    end
end
