class HomeworksController < ApplicationController
  before_action :set_homework, only: [:show, :edit, :update, :destroy, :change_phase]
  before_action :set_course
  before_action :set_unavailable

  # GET /homeworks
  # GET /homeworks.json
  def index
    if current_user.role?
      @homeworks = @course.homeworks
    else
      @homeworks = @course.homeworks.where(upload: true)
      if @homeworks[0]
        redirect_to homework_path(@homeworks[0])
      end
    end
  end

  def change_phase
    if params["phase"] != nil
      if params[:next]
        if @homework.actual_phase == "responder"
          @homework.actual_phase = "argumentar"
        elsif @homework.actual_phase == "argumentar"
          @homework.actual_phase = "rehacer"
        end
      elsif params[:previous]
        if @homework.actual_phase == "argumentar"
          @homework.actual_phase = "responder"
        elsif @homework.actual_phase == "rehacer"
          @homework.actual_phase = "argumentar"
        end
      end
      @homework.save
    end
    redirect_to homework_path(@homework.id)
  end

  def show
    @homework.upload = true
    @homework.save
    if current_user.role?
      @questions = Question.all
    else
      question = @homework.questions.where(:phase =>@homework.actual_phase)[0]
      puts @homework.actual_phase
      puts question.phase
      puts "esto muestra la fase"
      if current_user.answers.find_by_question_id([question.id])
        redirect_to edit_homework_question_answer_path(@homework, question, current_user.answers.find_by_question_id(question.id))
      else
        redirect_to new_homework_question_answer_path(@homework, question)
      end
      @answers = Answer.all
    end
  end

  def new
    @homework = Homework.new
  end

  def edit
  end

  def create
    @homework = Homework.new(homework_params)
    @course.homeworks << @homework
    respond_to do |format|
      if @homework.save
        format.html { redirect_to homeworks_path, notice: 'La actividad ha sido creada.' }
        format.json { render :show, status: :created, location: @homework }
      else
        format.html { render :new }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
      end
    end
    @homework.course_id = current_user.current_course_id
    @homework.save
    QuestionsController.new.create(@homework)
  end

  def update
    respond_to do |format|
      if @homework.update(homework_params)
        format.html { redirect_to homework_questions_path(@homework), notice: 'La actividad ha sido actualizada.' }
        format.json { render :show, status: :ok, location: @homework }
      else
        format.html { render :edit }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homeworks/1
  # DELETE /homeworks/1.json
  def destroy
    @homework.destroy
    respond_to do |format|
      format.html { redirect_to homeworks_url, notice: 'La actividad fue removida.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_homework
      @homework = Homework.find(params[:id])
    end

    def set_course
      @course = Course.find_by_id(current_user.current_course_id)
    end

    def set_unavailable
      if current_user.role?
        for i in @course.homeworks
          i.upload = false
          i.save
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def homework_params
      params.require(:homework).permit(:name, :content, :actual_phase, :upload, :courses)
    end
end
