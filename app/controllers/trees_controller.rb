class TreesController < ApplicationController
  before_action :set_tree, only: [:show, :edit, :update, :destroy]
  before_action :set_course, only: [:create, :new]
  before_action :set_tree_edx, only: [:edx_view]
  before_action :set_ef_visible
  before_action :set_breadcrumbs


  def edx_view
    @username = params['lis_person_sourcedid']
    @performance = @tree.user_tree_performances.find_by(user_id: current_user.id)
    
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

      
        if @tree.user_tree_performances.where(user_id: current_user.id).blank?              
          @performance = @tree.user_tree_performances.create(user_id: current_user.id)
        end

        render "edx_view", :locals => {:content_question => @tree.initial_content_question, :ct_question => @tree.initial_ct_question,
        :feedback_simple=> @tree.initial_simple_feedback, :feedback_complex => @tree.initial_complex_feedback,
        :type => "initial", :state => "not_seen", :feedback_quality => "none", :n => 0, :content_choices => @content_choices, :ct_choices => @ct_choices}

      elsif params[:state].to_s == "answered"


        if params[:content_choices] && params[:content_choices]
             @correct_content= true
             @correct_ct= true

             
             params[:content_choices].each_with_index.select {|element, i|
              if params[:content_choices][i]
               #puts "id: " + i.to_s + " boolean: " + params[:content_choices][i][].last
              end

              }

            @tree.initial_content_question.content_choices.each do |choice|

                
                #puts "controller_ choice id:"
                #puts choice.id
                #puts "controller: arreglo de choice id:"
                #puts "el valor es: " + params[:content_choices][choice.id.to_s]
                #puts params[:content_choices][choice.id][].last

                if params[:content_choices] && params[:content_choices][choice.id.to_s]

                  
                  
                  if choice.right.to_s != params[:content_choices][choice.id.to_s]
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

                if @performance
                  if @performance.content_sc.nil?
                    @performance.content_sc = 1
                    puts "le di el valor de 1 ------------------"
                  else
                    @performance.content_sc = @performance.content_sc + 1
                  end 

                  if @performance.n.nil?
                    puts "el n es NIL y lle di el valor 1--------------------------"
                    @performance.n = 1
                  else
                    puts "el n NO es NIL y el n es:-----------------------------------"
                    @performance.n = @performance.n.to_i + 1
                    puts @performance.n
                  end   

                  @tree.initial_ct_question.ct_habilities.each do |hab|
                    puts "habilidades del initial ct questions------------------------"
                    puts hab.name.to_s
                    if hab.active
                      if hab.name.to_s == "Interpretación"
                        if @performance.interpretation_sc.nil?
                          @performance.interpretation_sc = 1
                        else
                          @performance.interpretation_sc = @performance.interpretation_sc + 1
                        end                      
                      elsif hab.name.to_s == "Análisis"
                        if @performance.analysis_sc.nil?
                          @performance.analysis_sc = 1
                        else
                          @performance.analysis_sc = @performance.analysis_sc + 1
                        end 
                      elsif hab.name.to_s == "Evaluación"
                        if @performance.evaluation_sc.nil?
                          @performance.evaluation_sc = 1
                        else
                          @performance.evaluation_sc = @performance.evaluation_sc + 1
                        end 
                      elsif hab.name.to_s == "Inferencia"
                        if @performance.inference_sc.nil?
                          @performance.inference_sc = 1
                        else
                          @performance.inference_sc = @performance.inference_sc + 1
                        end 
                      elsif hab.name.to_s == "Explicación"
                        if @performance.explanation_sc.nil?
                          @performance.explanation_sc = 1
                        else
                         @performance.explanation_sc = @performance.explanation_sc + 1
                        end
                      elsif hab.name.to_s == "Autoregulación"
                        if @performance.selfregulation_sc.nil?
                          @performance.selfregulation_sc = 1
                        else
                          @performance.selfregulation_sc = @performance.selfregulation_sc + 1
                        end 
                      end
                    end
                  end
                end
                
                #puts "entre al correcto------------"
                render "edx_view", :locals => {:content_question => @tree.initial_content_question, :ct_question => @tree.initial_ct_question,
                :feedback_simple=> @tree.initial_simple_feedback, :feedback_complex => @tree.initial_complex_feedback,
                 :type => "initial", :state =>"answered", :feedback_quality => "none", :n => 0, :content_choices => @content_choices, :ct_choices => @ct_choices}



              elsif @correct_content == true && @correct_ct == false

                if @performance
                  if @performance.content_sc.nil?
                    @performance.content_sc = 1
                  else
                    @performance.content_sc = @performance.content_sc + 1
                  end  

                  if @performance.n.nil?
                    @performance.n = 1
                  else
                    @performance.n = @performance.n.to_i + 1
                  end  

                  @tree.initial_ct_question.ct_habilities.each do |hab|
                    puts "habilidades del initial ct questions------------------------"
                    puts hab.name.to_s
                    if hab.active
                      if hab.name.to_s == "Interpretación"
                        if @performance.interpretation_sc.nil?
                          @performance.interpretation_sc = 0
                        else
                          @performance.interpretation_sc = @performance.interpretation_sc
                        end                      
                      elsif hab.name.to_s == "Análisis"
                        if @performance.analysis_sc.nil?
                          @performance.analysis_sc = 0
                        else
                          @performance.analysis_sc = @performance.analysis_sc
                        end 
                      elsif hab.name.to_s == "Evaluación"
                        if @performance.evaluation_sc.nil?
                          @performance.evaluation_sc = 0
                        else
                          @performance.evaluation_sc = @performance.evaluation_sc
                        end 
                      elsif hab.name.to_s == "Inferencia"
                        if @performance.inference_sc.nil?
                          @performance.inference_sc = 0
                        else
                         @performance.inference_sc = @performance.inference_sc
                        end 
                      elsif hab.name.to_s == "Explicación"
                        if @performance.explanation_sc.nil?
                          @performance.explanation_sc = 0
                        else
                          @performance.explanation_sc = @performance.explanation_sc
                        end
                      elsif hab.name.to_s == "Autoregulación"
                        if @performance.selfregulation_sc.nil?
                          @performance.selfregulation_sc = 0
                        else
                          @performance.selfregulation_sc = @performance.selfregulation_sc
                        end 
                      end
                    end
                  end
                end
                render "edx_view", :locals => {:content_question => @tree.initial_content_question, :ct_question => @tree.initial_ct_question,
                :feedback_simple=> @tree.initial_simple_feedback, :feedback_complex => @tree.initial_complex_feedback,
                 :type => "initial", :state =>"answered", :feedback_quality => "simple", :n => 0, :content_choices => @content_choices, :ct_choices => @ct_choices}

              else
                if @performance
                  if @performance.content_sc.nil?
                    @performance.content_sc = 0
                  else
                    @performance.content_sc = @performance.content_sc
                  end  

                  if @performance.n.nil?
                    @performance.n = 1
                  else
                    @performance.n = @performance.n.to_i + 1
                  end  

                  @tree.initial_ct_question.ct_habilities.each do |hab|
                    if hab.active
                      puts "habilidades del initial ct questions------------------------"
                      puts hab.name.to_s
                      if hab.name.to_s == "Interpretación"
                        if@performance.interpretation_sc.nil?
                          @performance.interpretation_sc = 0
                        else
                          @performance.interpretation_sc = @performance.interpretation_sc
                        end
                        puts "el ptje interpretacion es:---------------"
                        puts @performance.interpretation_sc                      
                      elsif hab.name.to_s == "Análisis"
                        if @performance.analysis_sc.nil?
                          @performance.analysis_sc = 0
                        else
                         @performance.analysis_sc = @performance.analysis_sc
                        end
                        puts "el ptje analisis es:---------------"
                        puts @performance.analysis_sc 
                      elsif hab.name.to_s == "Evaluación"
                        if @performance.evaluation_sc.nil?
                          @performance.evaluation_sc = 0
                        else
                          @performance.evaluation_sc = @performance.evaluation_sc
                        end 
                      elsif hab.name.to_s == "Inferencia"
                        if @performance.inference_sc.nil?
                          @performance.inference_sc = 0
                        else
                          @performance.inference_sc = @performance.inference_sc
                        end 
                      elsif hab.name.to_s == "Explicación"
                        if @performance.explanation_sc.nil?
                          @performance.explanation_sc = 0
                        else
                          @performance.explanation_sc = @performance.explanation_sc
                        end
                      elsif hab.name.to_s == "Autoregulación"
                        if @performance.selfregulation_sc.nil?
                          @performance.selfregulation_sc = 0
                        else
                          @performance.selfregulation_sc = @performance.selfregulation_sc
                        end 
                      end
                    end
                  end
                end
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

                    if @performance
                      if @performance.content_sc.nil?
                        @performance.content_sc = 1
                        puts "le di el valor de 1 ------------------"
                      else
                        @performance.content_sc = @performance.content_sc + 1
                      end 

                      if @performance.n.nil?
                        puts "el n es NIL y lle di el valor 1--------------------------"
                        @performance.n = 1
                      else
                        puts "el n NO es NIL y el n es:-----------------------------------"
                        @performance.n = @performance.n.to_i + 1
                        puts @performance.n
                      end   

                      @tree.recuperative_ct_question.ct_habilities.each do |hab|
                        if hab.active
                          if hab.name.to_s == "Interpretación"
                            if @performance.interpretation_sc.nil?
                              @performance.interpretation_sc = 1
                            else
                              @performance.interpretation_sc = @performance.interpretation_sc + 1
                            end                            
                          elsif hab.name.to_s == "Análisis"
                            if @performance.analysis_sc.nil?
                              @performance.analysis_sc = 1
                            else
                              @performance.analysis_sc = @performance.analysis_sc + 1
                            end
                          elsif hab.name.to_s == "Evaluación"
                            if @performance.evaluation_sc.nil?
                              @performance.evaluation_sc = 1
                            else
                              @performance.evaluation_sc = @performance.evaluation_sc + 1
                            end 
                          elsif hab.name.to_s == "Inferencia"
                            if @performance.inference_sc.nil?
                              @performance.inference_sc = 1
                            else
                              @performance.inference_sc = @performance.inference_sc + 1
                            end 
                          elsif hab.name.to_s == "Explicación"
                            if @performance.explanation_sc.nil?
                              @performance.explanation_sc = 1
                            else
                             @performance.explanation_sc = @performance.explanation_sc + 1
                            end
                          elsif hab.name.to_s == "Autoregulación"
                            if @performance.selfregulation_sc.nil?
                              @performance.selfregulation_sc = 1
                            else
                              @performance.selfregulation_sc = @performance.selfregulation_sc + 1
                            end 
                          end
                        end
                      end
                    end

                    render "edx_view", :locals => {:content_question => @tree.recuperative_content_question, :ct_question => @tree.recuperative_ct_question,
                    :feedback_simple=> @tree.recuperative_simple_feedback, :feedback_complex => @tree.recuperative_complex_feedback,
                     :type => "recuperative", :state =>"answered", :feedback_quality => "none", :n => params[:n].to_i, :content_choices => @content_choices, :ct_choices => @ct_choices}
                    
                  elsif @correct_content == true && @correct_ct == false

                    if @performance
                      if @performance.content_sc.nil?
                        @performance.content_sc = 1
                      else
                        @performance.content_sc = @performance.content_sc + 1
                      end  

                      if @performance.n.nil?
                        @performance.n = 1
                      else
                        @performance.n = @performance.n.to_i + 1
                      end  

                      @tree.recuperative_ct_question.ct_habilities.each do |hab|
                        if hab.active
                          if hab.name.to_s == "Interpretación"
                            if @performance.interpretation_sc.nil?
                              @performance.interpretation_sc = 0
                            else
                              @performance.interpretation_sc = @performance.interpretation_sc
                            end                      
                          elsif hab.name.to_s == "Análisis"
                            if @performance.analysis_sc.nil?
                              @performance.analysis_sc = 0
                            else
                              @performance.analysis_sc = @performance.analysis_sc
                            end 
                          elsif hab.name.to_s == "Evaluación"
                            if @performance.evaluation_sc.nil?
                              @performance.evaluation_sc = 0
                            else
                              @performance.evaluation_sc = @performance.evaluation_sc
                            end 
                          elsif hab.name.to_s == "Inferencia"
                            if @performance.inference_sc.nil?
                              @performance.inference_sc = 0
                            else
                             @performance.inference_sc = @performance.inference_sc
                            end 
                          elsif hab.name.to_s == "Explicación"
                            if @performance.explanation_sc.nil?
                              @performance.explanation_sc = 0
                            else
                              @performance.explanation_sc = @performance.explanation_sc
                            end
                          elsif hab.name.to_s == "Autoregulación"
                            if @performance.selfregulation_sc.nil?
                              @performance.selfregulation_sc = 0
                            else
                              @performance.selfregulation_sc = @performance.selfregulation_sc
                            end 
                          end
                        end
                      end
                    end

                    render "edx_view", :locals => {:content_question => @tree.recuperative_content_question, :ct_question => @tree.recuperative_ct_question,
                    :feedback_simple=> @tree.recuperative_simple_feedback, :feedback_complex => @tree.recuperative_complex_feedback,
                     :type => "recuperative", :state =>"answered", :feedback_quality => "simple", :n => params[:n].to_i, :content_choices => @content_choices, :ct_choices => @ct_choices}

                  else

                    if @performance

                      if @performance.content_sc.nil?
                        @performance.content_sc = 0
                      else
                        @performance.content_sc = @performance.content_sc
                      end  

                      if @performance.n.nil?
                        @performance.n = 1
                      else
                        @performance.n = @performance.n.to_i + 1
                      end  

                      @tree.recuperative_ct_question.ct_habilities.each do |hab|
                        if hab.active
                          if hab.name.to_s == "Interpretación"
                            if@performance.interpretation_sc.nil?
                              @performance.interpretation_sc = 0
                            else
                              @performance.interpretation_sc = @performance.interpretation_sc
                            end                      
                          elsif hab.name.to_s == "Análisis"
                            if @performance.analysis_sc.nil?
                              @performance.analysis_sc = 0
                            else
                             @performance.analysis_sc = @performance.analysis_sc
                            end 
                          elsif hab.name.to_s == "Evaluación"
                            if @performance.evaluation_sc.nil?
                              @performance.evaluation_sc = 0
                            else
                              @performance.evaluation_sc = @performance.evaluation_sc
                            end 
                          elsif hab.name.to_s == "Inferencia"
                            if @performance.inference_sc.nil?
                              @performance.inference_sc = 0
                            else
                              @performance.inference_sc = @performance.inference_sc
                            end 
                          elsif hab.name.to_s == "Explicación"
                            if @performance.explanation_sc.nil?
                              @performance.explanation_sc = 0
                            else
                              @performance.explanation_sc = @performance.explanation_sc
                            end
                          elsif hab.name.to_s == "Autoregulación"
                            if @performance.selfregulation_sc.nil?
                              @performance.selfregulation_sc = 0
                            else
                              @performance.selfregulation_sc = @performance.selfregulation_sc
                            end 
                          end
                        end
                      end
                    end

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

                if @performance
                      if @performance.content_sc.nil?
                        @performance.content_sc = 1
                        puts "le di el valor de 1 ------------------"
                      else
                        @performance.content_sc = @performance.content_sc + 1
                      end 

                      if @performance.n.nil?
                        puts "el n es NIL y lle di el valor 1--------------------------"
                        @performance.n = 1
                      else
                        puts "el n NO es NIL y el n es:-----------------------------------"
                        @performance.n = @performance.n.to_i + 1
                        puts @performance.n
                      end   

                      @tree.deeping_ct_question.ct_habilities.each do |hab|
                        if hab.active
                          if hab.name.to_s == "Interpretación"
                            if @performance.interpretation_sc.nil?
                              @performance.interpretation_sc = 1
                            else
                              @performance.interpretation_sc = @performance.interpretation_sc + 1
                            end                      
                          elsif hab.name.to_s == "Análisis"
                            if @performance.analysis_sc.nil?
                              @performance.analysis_sc = 1
                            else
                              @performance.analysis_sc = @performance.analysis_sc + 1
                            end 
                          elsif hab.name.to_s == "Evaluación"
                            if @performance.evaluation_sc.nil?
                              @performance.evaluation_sc = 1
                            else
                              @performance.evaluation_sc = @performance.evaluation_sc + 1
                            end 
                          elsif hab.name.to_s == "Inferencia"
                            if @performance.inference_sc.nil?
                              @performance.inference_sc = 1
                            else
                              @performance.inference_sc = @performance.inference_sc + 1
                            end 
                          elsif hab.name.to_s == "Explicación"
                            if @performance.explanation_sc.nil?
                              @performance.explanation_sc = 1
                            else
                             @performance.explanation_sc = @performance.explanation_sc + 1
                            end
                          elsif hab.name.to_s == "Autoregulación"
                            if @performance.selfregulation_sc.nil?
                              @performance.selfregulation_sc = 1
                            else
                              @performance.selfregulation_sc = @performance.selfregulation_sc + 1
                            end 
                          end
                        end
                      end
                    end
                
                render "edx_view", :locals => {:content_question => @tree.deeping_content_question, :ct_question => @tree.deeping_ct_question,
                :feedback_simple=> @tree.deeping_simple_feedback, :feedback_complex => @tree.deeping_complex_feedback,
                 :type => "deeping", :state =>"answered", :feedback_quality => "none", :n => params[:n].to_i, :content_choices => params[:content_choices], :ct_choices => params[:ct_choices]}

                
              elsif @correct_content == true && @correct_ct == false

                if @performance
                      if @performance.content_sc.nil?
                        @performance.content_sc = 1
                      else
                        @performance.content_sc = @performance.content_sc + 1
                      end  

                      if @performance.n.nil?
                        @performance.n = 1
                      else
                        @performance.n = @performance.n.to_i + 1
                      end  

                      @tree.deeping_ct_question.ct_habilities.each do |hab|
                        if hab.active
                          if hab.name.to_s == "Interpretación"
                            if @performance.interpretation_sc.nil?
                              @performance.interpretation_sc = 0
                            else
                              @performance.interpretation_sc = @performance.interpretation_sc
                            end                      
                          elsif hab.name.to_s == "Análisis"
                            if @performance.analysis_sc.nil?
                              @performance.analysis_sc = 0
                            else
                              @performance.analysis_sc = @performance.analysis_sc
                            end 
                          elsif hab.name.to_s == "Evaluación"
                            if @performance.evaluation_sc.nil?
                              @performance.evaluation_sc = 0
                            else
                              @performance.evaluation_sc = @performance.evaluation_sc
                            end 
                          elsif hab.name.to_s == "Inferencia"
                            if @performance.inference_sc.nil?
                              @performance.inference_sc = 0
                            else
                             @performance.inference_sc = @performance.inference_sc
                            end 
                          elsif hab.name.to_s == "Explicación"
                            if @performance.explanation_sc.nil?
                              @performance.explanation_sc = 0
                            else
                              @performance.explanation_sc = @performance.explanation_sc
                            end
                          elsif hab.name.to_s == "Autoregulación"
                            if @performance.selfregulation_sc.nil?
                              @performance.selfregulation_sc = 0
                            else
                              @performance.selfregulation_sc = @performance.selfregulation_sc
                            end 
                          end
                        end
                      end
                    end

                render "edx_view", :locals => {:content_question => @tree.deeping_content_question, :ct_question => @tree.deeping_ct_question,
                :feedback_simple=> @tree.deeping_simple_feedback, :feedback_complex => @tree.deeping_complex_feedback,
                 :type => "deeping", :state =>"answered", :feedback_quality => "simple", :n => params[:n].to_i, :content_choices => params[:content_choices], :ct_choices => params[:ct_choices]}

              else

                if @performance

                      if @performance.content_sc.nil?
                        @performance.content_sc = 0
                      else
                        @performance.content_sc = @performance.content_sc
                      end  

                      if @performance.n.nil?
                        @performance.n = 1
                      else
                        @performance.n = @performance.n.to_i + 1
                      end  

                      @tree.deeping_ct_question.ct_habilities.each do |hab|
                        if hab.active
                          if hab.name.to_s == "Interpretación"
                            if@performance.interpretation_sc.nil?
                              @performance.interpretation_sc = 0
                            else
                              @performance.interpretation_sc = @performance.interpretation_sc
                            end                      
                          elsif hab.name.to_s == "Análisis"
                            if @performance.analysis_sc.nil?
                              @performance.analysis_sc = 0
                            else
                             @performance.analysis_sc = @performance.analysis_sc
                            end 
                          elsif hab.name.to_s == "Evaluación"
                            if @performance.evaluation_sc.nil?
                              @performance.evaluation_sc = 0
                            else
                              @performance.evaluation_sc = @performance.evaluation_sc
                            end 
                          elsif hab.name.to_s == "Inferencia"
                            if @performance.inference_sc.nil?
                              @performance.inference_sc = 0
                            else
                              @performance.inference_sc = @performance.inference_sc
                            end 
                          elsif hab.name.to_s == "Explicación"
                            if @performance.explanation_sc.nil?
                              @performance.explanation_sc = 0
                            else
                              @performance.explanation_sc = @performance.explanation_sc
                            end
                          elsif hab.name.to_s == "Autoregulación"
                            if @performance.selfregulation_sc.nil?
                              @performance.selfregulation_sc = 0
                            else
                              @performance.selfregulation_sc = @performance.selfregulation_sc
                            end 
                          end
                        end
                      end
                    end

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


    if @performance.nil?
    else
      puts "javieraaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      puts @performance.n
      @performance.save
      puts @performance.inspect
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

   
    @tree.build_initial_content_question
    4.times { @tree.initial_content_question.content_choices.build }

    @tree.build_initial_ct_question
    4.times { @tree.initial_ct_question.ct_choices.build }
    6.times { @tree.initial_ct_question.ct_habilities.build }
    
    @tree.build_recuperative_content_question
    4.times { @tree.recuperative_content_question.content_choices.build }

    @tree.build_recuperative_ct_question
    4.times { @tree.recuperative_ct_question.ct_choices.build }
    6.times { @tree.recuperative_ct_question.ct_habilities.build }

    @tree.build_deeping_content_question
    4.times { @tree.deeping_content_question.content_choices.build }

    @tree.build_deeping_ct_question
    4.times { @tree.deeping_ct_question.ct_choices.build }
    6.times { @tree.deeping_ct_question.ct_habilities.build }

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


    respond_to do |format|
      if @tree.save

        puts "cooooooooooooooosicossssssssa"
        @tree.initial_ct_question.ct_habilities.each do |hab|
          puts hab.name.to_s
          hab.ct_subhabilities.each do |subhab|
            puts subhab.name.to_s
          end
        end
        #puts @tree.recuperative_ct_question.ct_habilities.first.name
        #puts @tree.deeping_ct_question.ct_habilities.first.name
        

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
        initial_ct_question_attributes: [:id, :question, :_destroy, ct_habilities_attributes: [:id, :name, :description, :active, :ct_question_id, :_destroy, ct_subhabilities_attributes: [:id, :name, :description, :_destroy]], ct_choices_attributes: [:id, :text, :right, :ct_question_id, :_destroy]],
        recuperative_content_question_attributes: [:id, :question, :_destroy, content_choices_attributes: [:id, :text, :right, :content_question_id, :_destroy]],
        recuperative_ct_question_attributes: [:id, :question, :_destroy, ct_habilities_attributes: [:id, :name, :description, :active, :ct_question_id, :_destroy, ct_subhabilities_attributes: [:id, :name, :description, :_destroy]], ct_choices_attributes: [:id, :text, :right, :ct_question_id, :_destroy]],
        deeping_content_question_attributes: [:id, :question, :_destroy, content_choices_attributes: [:id, :text, :right, :content_question_id, :_destroy]],
        deeping_ct_question_attributes: [:id, :question, :_destroy, ct_habilities_attributes: [:id, :name, :description, :active, :ct_question_id, :_destroy, ct_subhabilities_attributes: [:id, :name, :description, :_destroy]], ct_choices_attributes: [:id, :text, :right, :ct_question_id, :_destroy]],
        initial_simple_feedback_attributes: [:id, :text, :_destroy],
        initial_complex_feedback_attributes: [:id, :text, :_destroy],
        recuperative_simple_feedback_attributes: [:id, :text, :_destroy],
        recuperative_complex_feedback_attributes: [:id, :text, :_destroy],
        deeping_simple_feedback_attributes: [:id, :text, :_destroy],
        deeping_complex_feedback_attributes: [:id, :text, :_destroy],
        user_tree_performances_attributes: [:id, :user_id, :tree_id, :content_sc, :interpretation_sc, :analysis_sc, :evaluation_sc, :inference_sc, :explanation_sc, :selfregulation_sc, :n]
     ) 
    end

    def ct_question_params
      params.require(:tree).permit(:question, :tree_id, ct_choices_attributes: [:text, :right], ct_habilities_attributes: [:name, :description, :active])
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

    def set_user_tree_performance
      @performance = Course.find(params[:tree_id => @tree.id, :user_id => current.user.id])
    end

end
