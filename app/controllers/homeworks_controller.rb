class HomeworksController < ApplicationController
  before_action :set_homework, only: [:show, :edit, :update, :destroy, :change_phase, :asistencia]
  before_action :set_course
  before_action :set_unavailable
  skip_before_action :set_unavailable, only: [:show, :change_phase, :answers]
  before_action :set_miscursos_visible, only: :index
  before_action :set_ef_visible, only: :index
  before_action :set_actividades_visible, only: [:index, :show, :asistencia, :edit, :new, :answers]
  before_action :set_configuraciones_visible, only: :index
  before_action :set_breadcrumbs

  def index
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
          @homework.upload = true
        elsif @homework.actual_phase == "argumentar"
          @homework.actual_phase = "rehacer"
          @homework.upload = true
        elsif @homework.actual_phase == "rehacer"
          @homework.actual_phase = "evaluar"
          @homework.upload = true
        elsif @homework.actual_phase == "evaluar"
          @homework.actual_phase = "final"
          @homework.upload = true
        end
      elsif params[:previous]
        if @homework.actual_phase == "argumentar"
          @homework.actual_phase = "responder"
          @homework.upload = true
        elsif @homework.actual_phase == "rehacer"
          @homework.actual_phase = "argumentar"
          @homework.upload = true
        elsif @homework.actual_phase == "evaluar"
          @homework.actual_phase = "rehacer"
          @homework.upload = true
        elsif @homework.actual_phase == "final"
          @homework.actual_phase = "evaluar"
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
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Actividades Colaborativas", "Realizar Actividad"]
    @users = User.all.where(role:0, asistencia:true)
    @homework.save
    if @homework.actual_phase == "responder"
      @siguiente = "Argumentar"
    elsif @homework.actual_phase == "argumentar"
      @siguiente = "Rehacer"
    elsif @homework.actual_phase == "rehacer"
      @siguiente = "Evaluar"
    elsif @homework.actual_phase == "evaluar"
      @siguiente = "Final"
    end
    if !current_user.role?
      redirect_to homework_answers_path(@homework)
    end
  end

  def new
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Actividades Colaborativas", "Crear Actividad"]
    @homework = Homework.new
  end

  def edit
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Actividades Colaborativas", "Editar Actividad"]
  end

  def answers
    @breadcrumbs = ["Mis Cursos", Course.find(current_user.current_course_id).name, "Actividades Colaborativas", "Realizar Actividad", "Respuesta Alumno"]
    @homework = Homework.where(id:params["homework"]["homework"].to_i)[0]
    @user = User.find_by_id(params["homework"]["user"])
    @partner = User.find_by_id(@user.partner_id)
    if @partner.partner_id != current_user.id && (@homework.actual_phase == "rehacer" || @homework.actual_phase == "final")
      @partner = User.find_by_id(@partner.partner_id)
    end
    @partner_answer = @partner.answers.find_by_homework_id(@homework.id)
    @answer = @user.answers.find_by_homework_id(@homework.id)
    render 'studentanswer'
  end

  def create
    if params["tag_in_index"]
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
    @homework.destroy
    respond_to do |format|
      format.html { redirect_to homeworks_url, notice: 'La actividad fue removida.' }
      format.json { head :no_content }
    end
  end

  def asistencia
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
        generate_partner_2
      end
    else
      @homework.upload = true
      @homework.current = true
      @homework.save
      redirect_to homework_path(@homework)
    end
  end

  def generate_partner
    if @@libres.length > 1
      if @@libres.length % 2 != 0
        while true do
          i1 = rand(@@libres.length)
          i2 = rand(@@libres.length)
          i3 = rand(@@libres.length)
          if i1 != i2 && i1 != i3 && i2 != i3
            orden = [i1, i2, i3].sort
            break
          end
        end
        p1 = @@libres[i1]
        p2 = @@libres[i2]
        p3 = @@libres[i3]
        p1.partner_id = p2.id
        p2.partner_id = p3.id
        p3.partner_id = p1.id
        p1.save
        p2.save
        p3.save
        @@libres.delete_at(orden.pop)
        @@libres.delete_at(orden.pop)
        @@libres.delete_at(orden.pop)
      end
      for i in 1..(@@libres.length/2)
        i1 = rand(@@libres.length)
        p1 = @@libres[i1]
        i2 = rand(@@libres.length)
        while i2 == i1 do
          i2 = rand(@@libres.length)
        end
        p2 = @@libres[i2]
        p1.partner_id = p2.id
        p2.partner_id = p1.id
        p1.save
        p2.save
        if i1 > i2
          @@libres.delete_at(i1)
          @@libres.delete_at(i2)
        else
          @@libres.delete_at(i2)
          @@libres.delete_at(i1)
        end
      end
      @homework.upload = true
      @homework.current = true
      @homework.save
      redirect_to homework_path(@homework)
    end
  end

  def generate_partner_2
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
          #i.actual_phase = "responder"
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
