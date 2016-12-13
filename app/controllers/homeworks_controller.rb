class HomeworksController < ApplicationController
  before_action :set_homework, only: [:show, :edit, :update, :destroy, :change_phase, :asistencia]
  before_action :set_course
  before_action :set_unavailable
  skip_before_action :set_unavailable, only: [:show, :change_phase, :answers]
  before_action :set_miscursos_visible, only: :index
  before_action :set_ef_visible, only: :index
  before_action :set_actividades_visible, only: [:index, :show, :asistencia, :edit, :new, :answers]
  before_action :set_reporte_visible , only: [:index]
  before_action :set_configuraciones_visible, only: :index
  before_action :set_breadcrumbs
  before_action :set_color

  def index
    if params["format"]
      if params["format"]["volver"]
        data = Register.new(button_id:16, user_id:current_user.id)
        data.save
      end
    end
    if current_user.role?
      @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Actividades Colaborativas"]
      for i in @course.homeworks
        i.current = false
        i.upload = false
        i.actual_phase = "responder"
        i.save
      end
      @homeworks = @course.homeworks.sort_by{|e| e[:created_at]}
    else
      @homework = @course.homeworks.where(current: true)[0]
      if @homework
        answers = current_user.answers.find_by_homework_id([@homework.id])
        if @homework.upload == false
          redirect_to homework_answers_path(@homework)
        elsif @homework.upload == true && answers == nil
          redirect_to new_homework_answer_path(@homework)
        elsif @homework.upload == true && answers != nil
          if @homework.actual_phase == "argumentar" && answers.argumentar == nil
            redirect_to edit_homework_answer_path(@homework, answers)
          elsif @homework.actual_phase == "rehacer" && answers.rehacer == nil
            redirect_to edit_homework_answer_path(@homework, answers)
          elsif @homework.actual_phase == "evaluar" && answers.evaluar == nil
            redirect_to edit_homework_answer_path(@homework, answers)
          elsif @homework.actual_phase == "final" && answers.final == nil
            redirect_to edit_homework_answer_path(@homework, answers)
          else
            redirect_to homework_answers_path(@homework)
          end
        end
      end
    end
  end

  def change_phase
    if params["phase"] != nil
      if params[:next]
        if @homework.actual_phase == "responder"
          @homework.actual_phase = "argumentar"
          data = Register.new(button_id:17, user_id:current_user.id)
        elsif @homework.actual_phase == "argumentar"
          @homework.actual_phase = "rehacer"
          data = Register.new(button_id:18, user_id:current_user.id)
        elsif @homework.actual_phase == "rehacer"
          @homework.actual_phase = "responder_2"
          data = Register.new(button_id:19, user_id:current_user.id)
        elsif @homework.actual_phase == "responder_2"
          @homework.actual_phase = "argumentar_2"
          data = Register.new(button_id:20, user_id:current_user.id)
        elsif @homework.actual_phase == "argumentar_2"
          @homework.actual_phase = "rehacer_2"
          data = Register.new(button_id:21, user_id:current_user.id)
        end
        @homework.upload = true
      elsif params[:previous]
        if @homework.actual_phase == "argumentar"
          @homework.actual_phase = "responder"
          data = Register.new(button_id:22, user_id:current_user.id)
        elsif @homework.actual_phase == "rehacer"
          @homework.actual_phase = "argumentar"
          data = Register.new(button_id:23, user_id:current_user.id)
        elsif @homework.actual_phase == "responder_2"
          @homework.actual_phase = "rehacer"
          data = Register.new(button_id:24, user_id:current_user.id)
        elsif @homework.actual_phase == "argumentar_2"
          @homework.actual_phase = "responder_2"
          data = Register.new(button_id:25, user_id:current_user.id)
        elsif @homework.actual_phase == "rehacer_2"
          @homework.actual_phase = "argumentar_2"
          data = Register.new(button_id:26, user_id:current_user.id)
        end
        @homework.upload = true
      elsif params[:discussion]
        if @homework.actual_phase == "responder"
          data = Register.new(button_id:27, user_id:current_user.id)
        elsif @homework.actual_phase == "argumentar"
          data = Register.new(button_id:28, user_id:current_user.id)
        elsif @homework.actual_phase == "rehacer"
          data = Register.new(button_id:29, user_id:current_user.id)
        elsif @homework.actual_phase == "responder_2"
          data = Register.new(button_id:30, user_id:current_user.id)
        elsif @homework.actual_phase == "argumentar_2"
          data = Register.new(button_id:31, user_id:current_user.id)
        elsif @homework.actual_phase == "rehacer_2"
          data = Register.new(button_id:32, user_id:current_user.id)
        end
        @homework.upload = false
      end
      data.save
      @homework.save
    end
    redirect_to homework_path(@homework.id)
  end

  def show
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Actividades Colaborativas", "Realizar Actividad"]
    @users = User.all.where(role:0, asistencia:true)
    @homework.save
    @ciclo = ""
    if current_user.role?
      if @homework.actual_phase == "responder"
        @ciclo = "Ciclo 1"
        @etapa = "Responder"
        @siguiente = "Argumentar"
      elsif @homework.actual_phase == "argumentar"
        @ciclo = "Ciclo 1"
        @etapa = "Argumentar"
        @siguiente = "Rehacer"
      elsif @homework.actual_phase == "rehacer"
        @ciclo = "Ciclo 1"
        @etapa = "Rehacer"
        @siguiente = "Responder"
      elsif @homework.actual_phase == "responder_2"
        @ciclo = "Ciclo 2"
        @etapa = "Responder"
        @siguiente = "Argumentar"
      elsif @homework.actual_phase == "argumentar_2"
        @ciclo = "Ciclo 2"
        @etapa = "Argumentar"
        @siguiente = "Rehacer"
      elsif @homework.actual_phase == "rehacer_2"
        @ciclo = "Ciclo 2"
        @etapa = "Rehacer"
      end
      if !@homework.upload
        @etapa = "Discusión"
      end
    else
      redirect_to homework_answers_path(@homework)
    end
  end

  def new
    data = Register.new(button_id:9, user_id:current_user.id)
    data.save
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Actividades Colaborativas", "Crear Actividad"]
    @homework = Homework.new
  end

  def edit
    data = Register.new(button_id:12, user_id:current_user.id)
    data.save
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Actividades Colaborativas", "Editar Actividad"]
  end

  def answers
    @ciclo = ""
    @etapa = ""

    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Actividades Colaborativas", "Realizar Actividad", "Respuesta Alumno"]
    @homework = Homework.where(id:params["homework"]["homework"].to_i)[0]

    if @homework.actual_phase == "responder"
      @ciclo = "Ciclo 1"
      @etapa = "Responder"
    elsif @homework.actual_phase == "argumentar"
      @ciclo = "Ciclo 1"
      @etapa = "Argumentar"
    elsif @homework.actual_phase == "rehacer"
      @ciclo = "Ciclo 1"
      @etapa = "Rehacer"
    elsif @homework.actual_phase == "responder_2"
      @ciclo = "Ciclo 2"
      @etapa = "Responder"
    elsif @homework.actual_phase == "argumentar_2"
      @ciclo = "Ciclo 2"
      @etapa = "Argumentar"
    elsif @homework.actual_phase == "rehacer_2"
      @ciclo = "Ciclo 2"
      @etapa = "Rehacer"
    end

    @user = User.find_by_id(params["homework"]["user"])
    @corregido = User.find_by_id(@user.corregido)
    @corrector = User.find_by_id(@user.corrector)
    if @homework.actual_phase == "argumentar" || @homework.actual_phase == "argumentar_2"
      @my_answer = @corregido.answers.find_by_homework_id(@homework.id)
      @partner_answer = @user.answers.find_by_homework_id(@homework.id)
    elsif @homework.actual_phase == "rehacer" || @homework.actual_phase == "rehacer_2"
      @my_answer = @user.answers.find_by_homework_id(@homework.id)
      @partner_answer = @corrector.answers.find_by_homework_id(@homework.id)
    else
      @my_answer = @user.answers.find_by_homework_id(@homework.id)
      @partner_answer = @corregido.answers.find_by_homework_id(@homework.id)
    end
    data = Register.new(button_id:33, user_id:current_user.id)
    data.save
    render 'studentanswer'
  end

  def create
    if params["tag_in_index"]
      data = Register.new(button_id:36, user_id:current_user.id)
      data.save
      @homework = Homework.where(id:params["actualizar"]["homework"])[0]
      answers = current_user.answers.find_by_homework_id([@homework.id])
      if params["tag_in_index"] == "Editar Respuesta" && @homework.upload
        redirect_to edit_homework_answer_path(@homework, answers)
      else
        redirect_to homework_answers_path(@homework)
      end
    else
      @homework = Homework.new(homework_params)
      @course.homeworks << @homework
      data = Register.new(button_id:10, user_id:current_user.id)
      data.save
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
    end
  end

  def update
    data = Register.new(button_id:13, user_id:current_user.id)
    data.save
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

  def destroy
    data = Register.new(button_id:11, user_id:current_user.id)
    data.save
    @homework.destroy
    respond_to do |format|
      format.html { redirect_to homeworks_url, notice: 'La actividad fue removida.' }
      format.json { head :no_content }
    end
  end

  def asistencia
    data = Register.new(button_id:14, user_id:current_user.id)
    data.save
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Actividades Colaborativas", "Asistencia"]
    @users = Course.find_by_id(current_user.current_course_id).users
    @@libres = []
    if -(current_user.last_asistencia - DateTime.now).to_i > 1800 || @homework.id != current_user.last_homework
      if params["asistentes"] != nil
        current_user.last_homework = @homework.id
        current_user.last_asistencia = DateTime.now
        current_user.save
        params["asistentes"].each do |p|
          asistente = User.find_by_id(p[0])
          asistente.asistencia = p[1]['asistencia']
          if asistente.asistencia
            @@libres.append(asistente)
          end
          asistente.save
        end
        generate_partner
      end
      data = Register.new(button_id:15, user_id:current_user.id)
      data.save
    else
      @homework.upload = true
      @homework.current = true
      @homework.save
      redirect_to homework_path(@homework)
    end
  end

  def generate_partner
    i = rand(@@libres.length)
    cabeza = @@libres[i]
    anterior = @@libres[i]
    @@libres.delete_at(i)
    while @@libres.length > 1
      i = rand(@@libres.length)
      actual = @@libres[i]
      actual.corrector = anterior.id
      anterior.corregido = actual.id
      anterior.save
      anterior = actual
      @@libres.delete_at(i)
    end
    actual = @@libres[0]
    actual.corrector = anterior.id
    anterior.corregido = actual.id
    cabeza.corrector = actual.id
    actual.corregido = cabeza.id
    anterior.save
    actual.save
    cabeza.save
    @@libres.delete_at(0)
    @homework.upload = true
    @homework.current = true
    @homework.save
    redirect_to homework_path(@homework)
  end

  private
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

    def set_breadcrumbs
      @breadcrumbs = []
    end

    def image_up
      if Homework.find(params[:id]).image?
        @h_image = true
      end
    end

    def homework_params
      params.require(:homework).permit(:name, :content, :actual_phase, :upload, :courses, :image, :current)
    end
end
