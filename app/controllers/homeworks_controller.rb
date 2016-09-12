class HomeworksController < ApplicationController
  before_action :set_homework, only: [:show, :edit, :update, :destroy, :change_phase, :asistencia]
  before_action :set_course
  before_action :set_unavailable
  before_action :set_miscursos_visible, only: :index
  before_action :set_ef_visible, only: :index
  before_action :set_reporte_visible, only: :index
  before_action :set_actividades_visible, only: [:index, :show, :asistencia, :edit, :new]
  before_action :set_configuraciones_visible, only: :index

  # GET /homeworks
  # GET /homeworks.json
  def index
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Actividades"]
    if current_user.role?
      @homeworks = @course.homeworks.sort_by{|e| e[:created_at]}
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
          @homework.upload = true
        elsif @homework.actual_phase == "argumentar"
          @homework.actual_phase = "rehacer"
          @homework.upload = true
        end
      elsif params[:previous]
        if @homework.actual_phase == "argumentar"
          @homework.actual_phase = "responder"
          @homework.upload = true
        elsif @homework.actual_phase == "rehacer"
          @homework.actual_phase = "argumentar"
          @homework.upload = true
        end
      elsif params[:discussion]
        @homework.upload = false
      end
      @homework.save
    end
    redirect_to homework_path(@homework.id)
  end

  def show
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Actividades", "Realizar Actividad"]
    @users = User.all.where(role:0, asistencia:true)
    @homework.save
    if current_user.role?
      @questions = Question.all
    else
      questions = @homework.questions
      for q in @homework.questions
        if q.phase == @homework.actual_phase
          question = q
        end
      end
      if current_user.answers.find_by_question_id([question.id])
        redirect_to edit_homework_question_answer_path(@homework, question, current_user.answers.find_by_question_id(question.id))
      else
        redirect_to new_homework_question_answer_path(@homework, question)
      end
      @answers = Answer.all
    end
  end

  def new
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Actividades", "Crear Actividad"]
    @homework = Homework.new
  end

  def edit
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Actividades", "Editar Actividad"]
  end

  def answers
    @user = User.find_by_id(params["homework"]["user"])
    @homework = Homework.where(id:params["homework"]["homework"].to_i)[0]
    render 'studentanswer'
  end

  def create
    if params["tag_in_index"]
      @homework = Homework.where(upload:true)[0]
      for q in @homework.questions
        if q.phase == @homework.actual_phase
          question = q
        end
      end
      if params["tag_in_index"] == "Editar Respuesta"
        redirect_to homeworks_path
      elsif params["tag_in_index"] == "Actualizar" && current_user.answers.find_by_question_id([question.id]) == nil
        redirect_to new_homework_question_answer_path(@homework, question)
      else
        redirect_to homework_question_answers_path(@homework, question)
      end
    else
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
  end

  def update
    for question in @homework.questions
      question.update(content:@homework.content)
      question.save
    end
    respond_to do |format|
      if @homework.update(homework_params)
        format.html { redirect_to homeworks_path } # REDIRECT TO INDEX
        format.json { render :index, status: :ok }
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

  def asistencia
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Actividades", "Asistencia"]
    @users = Course.find_by_id(current_user.current_course_id).users
    libres = []
    if params["asistentes"] != nil
      params["asistentes"].each do |p|
        asistente = User.find_by_id(p[0])
        asistente.partner_id = nil
        asistente.asistencia = p[1]['asistencia']
        if asistente.asistencia
          libres.append(asistente)
        end
        asistente.save
      end
      if libres.length > 1
        if libres.length % 2 != 0
          while true do
            i1 = rand(libres.length)
            i2 = rand(libres.length)
            i3 = rand(libres.length)
            if i1 != i2 && i1 != i3 && i2 != i3
              orden = [i1, i2, i3].sort
              break
            end
          end
          p1 = libres[i1]
          p2 = libres[i2]
          p3 = libres[i3]
          p1.partner_id = p2.id
          p2.partner_id = p3.id
          p3.partner_id = p1.id
          p1.save
          p2.save
          p3.save
          libres.delete_at(orden.pop)
          libres.delete_at(orden.pop)
          libres.delete_at(orden.pop)
        end
        for i in 1..(libres.length/2)
          i1 = rand(libres.length)
          p1 = libres[i1]
          i2 = rand(libres.length)
          while i2 == i1 do
            i2 = rand(libres.length)
          end
          p2 = libres[i2]
          p1.partner_id = p2.id
          p2.partner_id = p1.id
          p1.save
          p2.save
          if i1 > i2
            libres.delete_at(i1)
            libres.delete_at(i2)
          else
            libres.delete_at(i2)
            libres.delete_at(i1)
          end
        end
        @homework.upload = true
        @homework.save
        redirect_to homework_path(@homework)
      end
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
    def homework_params
      params.require(:homework).permit(:name, :content, :actual_phase, :upload, :courses)
    end
end
