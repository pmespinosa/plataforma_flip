class TreesController < ApplicationController
  before_action :set_tree, only: [:show, :edit, :update, :destroy]
  before_action :set_course, only: [:create, :new]
  before_action :set_tree_edx, only: [:edx_view]
  before_action :set_ef_visible
  before_action :set_breadcrumbs


  def edx_view
    @username = params['lis_person_sourcedid']
    #render 'edx_view'
    puts "aca-------------------------"
    puts params[:type].to_s

    if params[:content_choices]
      @content_choices = params[:content_choices]
    else
      @content_choices = nil
    end

    if params[:ct_choices]
      @ct_choices = params[:ct_choices]
    else
      @ct_choices = nil
    end
  
    if params[:type].to_s == "initial"


      if params[:state].to_s == "not_seen"

        render "edx_view", :locals => {:content_question => @tree.initial_content_question, :ct_question => @tree.initial_ct_question,
        :feedback_simple=> @tree.initial_simple_feedback, :feedback_complex => @tree.initial_complex_feedback,
        :type => "initial", :state => "not_seen", :feedback_quality => "none", :n => 0, :content_choices => @content_choices, :ct_choices => @ct_choices}



      elsif params[:state].to_s == "answered"


        if params[:content_choices] && params[:content_choices]
             @correct_content= true
             @correct_ct= true

             puts "PREVIA PARAMETROS.............................."
             params[:content_choices].each_with_index.select {|element, i|
              if params[:content_choices][i]
               #puts "id: " + i.to_s + " boolean: " + params[:content_choices][i][].last
              end

              }

            @tree.initial_content_question.content_choices.each do |choice|

                puts "controllr: antes de entrar al if de content. Todo array y array del id de choice"
                puts params[:content_choices]
                #puts "controller_ choice id:"
                #puts choice.id
                #puts "controller: arreglo de choice id:"
                #puts "el valor es: " + params[:content_choices][choice.id.to_s]
                #puts params[:content_choices][choice.id][].last

                if params[:content_choices] && params[:content_choices][choice.id.to_s]

                  puts "probandooo_antes------------"
                  puts "ID: " + choice.id.to_s + " right?: " + choice.right.to_s
                  if choice.right.to_s != params[:content_choices][choice.id.to_s]
                    puts "entre al if"
                    @correct_content = false
                    break
                  end
                end
            end

            @tree.initial_ct_question.ct_choices.each do |choice|

                if params[:ct_choices] && params[:ct_choices][choice.id.to_s]
                  if choice.right.to_s != params[:ct_choices][choice.id.to_s]
                    @correct_ct = false
                    break
                  end
                end
            end

            #puts "probandooooooooooooooooooooo------------"
            #puts "contenido: " + @correct_content.to_s
            #puts "pc:" +  @correct_ct.to_s

              if @correct_ct == true && @correct_content == true
                #puts "entre al correcto------------"
                render "edx_view", :locals => {:content_question => @tree.initial_content_question, :ct_question => @tree.initial_ct_question,
                :feedback_simple=> @tree.initial_simple_feedback, :feedback_complex => @tree.initial_complex_feedback,
                 :type => "initial", :state =>"answered", :feedback_quality => "none", :n => 0, :content_choices => @content_choices, :ct_choices => @ct_choices}

              elsif @correct_content == true && @correct_ct == false
                render "edx_view", :locals => {:content_question => @tree.initial_content_question, :ct_question => @tree.initial_ct_question,
                :feedback_simple=> @tree.initial_simple_feedback, :feedback_complex => @tree.initial_complex_feedback,
                 :type => "initial", :state =>"answered", :feedback_quality => "simple", :n => 0, :content_choices => @content_choices, :ct_choices => @ct_choices}

              else
                render "edx_view", :locals => {:content_question => @tree.initial_content_question, :ct_question => @tree.initial_ct_question,
                :feedback_simple=> @tree.initial_simple_feedback, :feedback_complex => @tree.initial_complex_feedback,
                 :type => "initial", :state => "answered", :feedback_quality => "complex", :n => 0, :content_choices => @content_choices, :ct_choices => @ct_choices}
              end

          else
            render "edx_view", :locals => {:content_question => @tree.deeping_content_question, :ct_question => @tree.deeping_ct_question,
                :feedback_simple=> @tree.deeping_simple_feedback, :feedback_complex => @tree.deeping_complex_feedback,
                :type => "deeping", :state =>"not_seen", :feedback_quality => "none", :n => 0, :content_choices => @content_choices, :ct_choices => @ct_choices}

                       end    

      elsif params[:state].to_s == "feedback_seen"
          render "edx_view", :locals => {:content_question => @tree.recuperative_content_question, :ct_question => @tree.recuperative_ct_question,
              :feedback_simple=> @tree.recuperative_simple_feedback, :feedback_complex => @tree.recuperative_complex_feedback,
              :type => "recuperative", :state => "not_seen", :feedback_quality => "none", :n => 0, :content_choices => @content_choices, :ct_choices => @ct_choices}
      end

    elsif params[:type] == "recuperative"

      if params[:state].to_s == "answered"

        if params[:content_choices] && params[:content_choices]
                 @correct_content= true
                 @correct_ct= true

                 @tree.recuperative_content_question.content_choices.each do |choice|

                    puts "controllr: antes de entrar al if de content. Todo array y array del id de choice"
                    puts params[:content_choices]
                    #puts "controller_ choice id:"
                    #puts choice.id
                    #puts "controller: arreglo de choice id:"
                    #puts "el valor es: " + params[:content_choices][choice.id.to_s]
                    #puts params[:content_choices][choice.id][].last

                    if params[:content_choices] && params[:content_choices][choice.id.to_s]

                      puts "probandooo_antes------------"
                      puts "ID: " + choice.id.to_s + " right?: " + choice.right.to_s
                      if choice.right.to_s != params[:content_choices][choice.id.to_s]
                        puts "entre al if"
                        @correct_content = false
                        break
                      end
                    end
                end

                @tree.recuperative_ct_question.ct_choices.each do |choice|

                    if params[:ct_choices] && params[:ct_choices][choice.id.to_s]
                      if choice.right.to_s != params[:ct_choices][choice.id.to_s]
                        @correct_ct = false
                        break
                      end
                    end
                end

                  if @correct_ct == true && @correct_content == true
                    render "edx_view", :locals => {:content_question => @tree.recuperative_content_question, :ct_question => @tree.recuperative_ct_question,
                    :feedback_simple=> @tree.recuperative_simple_feedback, :feedback_complex => @tree.recuperative_complex_feedback,
                     :type => "recuperative", :state =>"answered", :feedback_quality => "none", :n => params[:n].to_i, :content_choices => @content_choices, :ct_choices => @ct_choices}
                    
                  elsif @correct_content == true && @correct_ct == false
                    render "edx_view", :locals => {:content_question => @tree.recuperative_content_question, :ct_question => @tree.recuperative_ct_question,
                    :feedback_simple=> @tree.recuperative_simple_feedback, :feedback_complex => @tree.recuperative_complex_feedback,
                     :type => "recuperative", :state =>"answered", :feedback_quality => "simple", :n => params[:n].to_i, :content_choices => @content_choices, :ct_choices => @ct_choices}

                  else
                    render "edx_view", :locals => {:content_question => @tree.recuperative_content_question, :ct_question => @tree.recuperative_ct_question,
                    :feedback_simple=> @tree.recuperative_simple_feedback, :feedback_complex => @tree.recuperative_complex_feedback,
                     :type => "recuperative", :state =>"answered", :feedback_quality => "complex", :n => params[:n].to_i, :content_choices => @content_choices, :ct_choices => @ct_choices}
                  end

            else
              render "edx_view", :locals => {:content_question => @tree.deeping_content_question, :ct_question => @tree.deeping_ct_question,
                    :feedback_simple=> @tree.deeping_simple_feedback, :feedback_complex => @tree.deeping_complex_feedback,
                    :type => "deeping", :state =>"not_seen", :feedback_quality => "none", :n => 0, :content_choices => @content_choices, :ct_choices => @ct_choices}

                            end

      elsif params[:state].to_s == "feedback_seen"

        if params[:n].to_i < 2
          render "edx_view", :locals => {:content_question => @tree.recuperative_content_question, :ct_question => @tree.recuperative_ct_question,
              :feedback_simple=> @tree.recuperative_simple_feedback, :feedback_complex => @tree.recuperative_complex_feedback,
              :type => "recuperative", :state => "not_seen", :feedback_quality => "none", :n => params[:n].to_i, :content_choices => @content_choices, :ct_choices => @ct_choices}
        else
          render "edx_view", :locals => {:content_question => @tree.recuperative_content_question, :ct_question => @tree.recuperative_ct_question,
              :feedback_simple=> @tree.recuperative_simple_feedback, :feedback_complex => @tree.recuperative_complex_feedback,
              :type => "deeping", :state => "end", :feedback_quality => "none", :n => 2, :content_choices => @content_choices, :ct_choices => @ct_choices}
        end

      end


    elsif params[:type].to_s == "deeping"

      if params[:state].to_s == "answered"

        if params[:content_choices] && params[:ct_choices]
             @correct_content = true
             @correct_ct = true

             @tree.deeping_content_question.content_choices.each do |choice|

                puts "controllr: antes de entrar al if de content. Todo array y array del id de choice"
                puts params[:content_choices]
                #puts "controller_ choice id:"
                #puts choice.id
                #puts "controller: arreglo de choice id:"
                #puts "el valor es: " + params[:content_choices][choice.id.to_s]
                #puts params[:content_choices][choice.id][].last

                if params[:content_choices] && params[:content_choices][choice.id.to_s]

                  puts "probandooo_antes------------"
                  puts "ID: " + choice.id.to_s + " right?: " + choice.right.to_s
                  if choice.right.to_s != params[:content_choices][choice.id.to_s]
                    puts "entre al if"
                    @correct_content = false
                    break
                  end
                end
            end

            @tree.deeping_ct_question.ct_choices.each do |choice|

                if params[:ct_choices] && params[:ct_choices][choice.id.to_s]
                  if choice.right.to_s != params[:ct_choices][choice.id.to_s]
                    @correct_ct = false
                    break
                  end
                end
            end

              if @correct_ct == true && @correct_content == true
                
                render "edx_view", :locals => {:content_question => @tree.deeping_content_question, :ct_question => @tree.deeping_ct_question,
                :feedback_simple=> @tree.deeping_simple_feedback, :feedback_complex => @tree.deeping_complex_feedback,
                 :type => "deeping", :state =>"answered", :feedback_quality => "none", :n => params[:n].to_i, :content_choices => params[:content_choices], :ct_choices => params[:ct_choices]}

                
              elsif @correct_content == true && @correct_ct == false
                render "edx_view", :locals => {:content_question => @tree.deeping_content_question, :ct_question => @tree.deeping_ct_question,
                :feedback_simple=> @tree.deeping_simple_feedback, :feedback_complex => @tree.deeping_complex_feedback,
                 :type => "deeping", :state =>"answered", :feedback_quality => "simple", :n => params[:n].to_i, :content_choices => params[:content_choices], :ct_choices => params[:ct_choices]}

              else
                render "edx_view", :locals => {:content_question => @tree.deeping_content_question, :ct_question => @tree.deeping_ct_question,
                :feedback_simple=> @tree.deeping_simple_feedback, :feedback_complex => @tree.deeping_complex_feedback,
                 :type => "deeping", :state => "answered", :feedback_quality => "complex", :n => params[:n].to_i, :content_choices => params[:content_choices], :ct_choices => params[:ct_choices]}
              end

      else
        render "edx_view", :locals => {:content_question => @tree.deeping_content_question, :ct_question => @tree.deeping_ct_question,
                  :feedback_simple=> @tree.deeping_simple_feedback, :feedback_complex => @tree.deeping_complex_feedback,
                  :type => "deeping", :state => "end", :feedback_quality => "none", :n => 2, :content_choices => params[:content_choices], :ct_choices => params[:ct_choices]}

      end

      elsif params[:state].to_s == "feedback_seen"
        if params[:n].to_i < 2
          render "edx_view", :locals => {:content_question => @tree.deeping_content_question, :ct_question => @tree.deeping_ct_question,
            :feedback_simple=> @tree.deeping_simple_feedback, :feedback_complex => @tree.deeping_complex_feedback,
            :type => "deeping", :state =>"not_seen", :feedback_quality => "none", :n => params[:n].to_i, :content_choices => params[:content_choices], :ct_choices => params[:ct_choices]}

        else
          render "edx_view", :locals => {:content_question => @tree.deeping_content_question, :ct_question => @tree.deeping_ct_question,
              :feedback_simple=> @tree.deeping_simple_feedback, :feedback_complex => @tree.deeping_complex_feedback,
              :type => "deeping", :state => "end", :feedback_quality => "none", :n => 2, :content_choices => params[:content_choices], :ct_choices => params[:ct_choices]}
        end

      end
    end
  end


  def addCtHability name, question

    if question.to_s == "initial"

    elsif question.to_s == "recuperative"

    elsif  question.to_s == "deeping"
        puts "pabloooooooooooooooooooooooooooooooooooooooooooooooo" + name.to_s
    end

  end


  def change_initial
       @initial = false
       edx_view
  end

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
    @breadcrumbs = ["Mis Cursos", @course.name, "Evaluación Formativa", "Nueva evaluación de video"]
    @tree = Tree.new

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

    @tree.build_initial_simple_feedback
    @tree.build_initial_complex_feedback
    @tree.build_recuperative_simple_feedback
    @tree.build_recuperative_complex_feedback
    @tree.build_deeping_simple_feedback
    @tree.build_deeping_complex_feedback

  end

  # GET /trees/1/edit
  def edit
    @breadcrumbs = ["Mis Cursos", @course.name, "Evaluación Formativa", "Editar evaluación de video"]
    @tree.build_content if @tree.content.nil?
    @tree.build_initial_content_question if @tree.initial_content_question.nil?
    @tree.build_initial_ct_question if @tree.initial_ct_question.nil?
    @tree.build_recuperative_content_question if @tree.recuperative_content_question.nil?
    @tree.build_recuperative_ct_question if @tree.recuperative_ct_question.nil?
    @tree.build_deeping_content_question if @tree.deeping_content_question.nil?
    @tree.build_deeping_ct_question if @tree.deeping_content_question.nil?


    @tree.build_initial_simple_feedback if @tree.initial_simple_feedback.nil?
    @tree.build_initial_complex_feedback if @tree.initial_complex_feedback.nil?
    @tree.build_recuperative_simple_feedback if @tree.recuperative_simple_feedback.nil?
    @tree.build_recuperative_complex_feedback if @tree.recuperative_complex_feedback.nil?
    @tree.build_deeping_simple_feedback if @tree.deeping_simple_feedback.nil?
    @tree.build_deeping_complex_feedback if @tree.deeping_complex_feedback.nil?

  end

  # POST /trees
  # POST /trees.json
  def create
    #@tree = Tree.new(tree_params)
    #@course = Course.find(:course_id)
    @tree = @course.trees.new(tree_params)

   
    if params[:initialCT]
      params[:initialCT].each do |hability|
        if hability.to_s == "interpretation"
          @tree.initial_ct_question.ct_habilities << CtHability.find_by(name: "Interpretación")
        elsif hability.to_s == "analysis"
          @tree.initial_ct_question.ct_habilities << CtHability.find_by(name: "Análisis")
        elsif hability.to_s == "evaluation"
          @tree.initial_ct_question.ct_habilities << CtHability.find_by(name: "Evaluación")
        elsif hability.to_s == "inference"
          @tree.initial_ct_question.ct_habilities << CtHability.find_by(name: "Inferencia")
        elsif hability.to_s == "explanation"
          @tree.initial_ct_question.ct_habilities << CtHability.find_by(name: "Explicación")
        elsif hability.to_s == "selfregulation"
          @tree.initial_ct_question.ct_habilities << CtHability.find_by(name: "Autoregulación")
        end
      end
    end

    if params[:recuperativeCT]
      params[:recuperativeCT].each do |hability|
        if hability.to_s == "interpretation"
          @tree.recuperative_ct_question.ct_habilities << CtHability.find_by_name("Interpretación")
        elsif hability.to_s == "analysis"
          @tree.recuperative_ct_question.ct_habilities << CtHability.find_by_name("Análisis")
        elsif hability.to_s == "evaluation"
          @tree.recuperative_ct_question.ct_habilities << CtHability.find_by_name("Evaluación")
        elsif hability.to_s == "inference"
          @tree.recuperative_ct_question.ct_habilities << CtHability.find_by_name("Inferencia")
        elsif hability.to_s == "explanation"
          @tree.recuperative_ct_question.ct_habilities << CtHability.find_by_name("Explicación")
        elsif hability.to_s == "selfregulation"
          @tree.recuperative_ct_question.ct_habilities << CtHability.find_by_name("Autoregulación")
        end
      end
    end

    if params[:deepingCT]
      params[:deepingCT].each do |hability|
        if hability.to_s == "interpretation"
          @tree.deeping_ct_question.ct_habilities << CtHability.find_by_name("Interpretación")
        elsif hability.to_s == "analysis"
          @tree.deeping_ct_question.ct_habilities << CtHability.find_by_name("Análisis")
        elsif hability.to_s == "evaluation"
          @tree.deeping_ct_question.ct_habilities << CtHability.find_by_name("Evaluación")
        elsif hability.to_s == "inference"
          @tree.deeping_ct_question.ct_habilities << CtHability.find_by_name("Inferencia")
        elsif hability.to_s == "explanation"
          @tree.deeping_ct_question.ct_habilities << CtHability.find_by_name("Explicación")
        elsif hability.to_s == "selfregulation"
          @tree.deeping_ct_question.ct_habilities << CtHability.find_by_name("Autoregulación")
        end
      end
    end


    respond_to do |format|
      if @tree.save
        #puts "cooooooooooooooosicossssssssa"

        #@tree.initial_ct_question.ct_habilities.each do |hability|
         # puts hability.name
        #end
        #@tree.recuperative_ct_question.ct_habilities.each do |hability|
         # puts hability.name
        #end 
        #@tree.recuperative_ct_question.ct_habilities.each do |hability|
         # puts hability.name
        #end   
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
      format.html { redirect_to @course, notice: 'Tree was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_tree
      @course = Course.find(params[:course_id])
      @tree = @course.trees.find(params[:id])

    end

    def set_tree_edx
      @course = Course.find(params[:course_id])
      @tree = @course.trees.find(params[:id])

    end

    def set_course
      @course = Course.find(params[:course_id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tree_params
      params.require(:tree).permit(:video, content_attributes: [:id, :text],
        initial_content_question_attributes: [:id, :question, :_destroy, content_choices_attributes: [:id, :text, :right, :content_question_id, :_destroy]],
        initial_ct_question_attributes: [:id, :question, :ct_habilities, :_destroy, ct_choices_attributes: [:id, :text, :right, :ct_question_id, :_destroy]],
        recuperative_content_question_attributes: [:id, :question, :_destroy, content_choices_attributes: [:id, :text, :right, :content_question_id, :_destroy]],
        recuperative_ct_question_attributes: [:id, :question, :ct_habilities, :_destroy, ct_choices_attributes: [:id, :text, :right, :ct_question_id, :_destroy]],
        deeping_content_question_attributes: [:id, :question, :_destroy, content_choices_attributes: [:id, :text, :right, :content_question_id, :_destroy]],
        deeping_ct_question_attributes: [:id, :question, :ct_habilities, :_destroy, ct_choices_attributes: [:id, :text, :right, :ct_question_id, :_destroy]],
        initial_simple_feedback_attributes: [:id, :text, :_destroy],
        initial_complex_feedback_attributes: [:id, :text, :_destroy],
        recuperative_simple_feedback_attributes: [:id, :text, :_destroy],
        recuperative_complex_feedback_attributes: [:id, :text, :_destroy],
        deeping_simple_feedback_attributes: [:id, :text, :_destroy],
        deeping_complex_feedback_attributes: [:id, :text, :_destroy]
        )
    end

    def ct_question_params
      params.require(:tree).permit(:question, :tree_id, ct_choices_attributes: [:text, :right])
    end

    def content_question_params
      params.require(:tree).permit(:question, :tree_id, content_choices_attributes: [:text, :right])
    end

    def set_ef_visible
      @ef_visible = true
    end

    def set_reporte_visible
      @reporte_visible = true
    end

    def set_breadcrumbs
      @breadcrumbs = []
    end

end
