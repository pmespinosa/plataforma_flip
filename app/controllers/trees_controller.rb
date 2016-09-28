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

   
    @tree.build_initial_content_question
    4.times { @tree.initial_content_question.content_choices.build }

    @tree.build_initial_ct_question
    4.times { @tree.initial_ct_question.ct_choices.build }

    @tree.initial_ct_question.ct_habilities.build(name: 'Interpretación', description: "To comprehend and express the meaning or significance of a wide
variety of experiences, situations, data, events, judgments, conventions, beliefs, rules,
procedures or criteria.", active: false, :ct_subhabilities_attributes => [{name: 'Categorización', description: "-To apprehend or appropriately formulate categories, distinctions, or frameworks
for understanding, describing or characterizing information.
-To describe experiences, situations, beliefs, events, etc. so that they take on
comprehensible meanings in terms of appropriate categorizations, distinctions, or
frameworks."}, {name: "Decodificar significado", description: "To detect, attend to, and describe the informational content, affective purport,
directive functions, intentions, motives, purposes, social significance, values, views, rules,
procedures, criteria, or inferential relationships expressed in convention-based
communication systems, such as in language, social behaviors, drawings, numbers, graphs,
tables, charts, signs and symbols."}, {name: 'Clarificar significados', description: "-To paraphrase or make explicit, through stipulation, description, analogy or
figurative expression, the contextual, conventional or intended meanings of words, ideas,
concepts, statements, behaviors, drawings, numbers, signs, charts, graphs, symbols, rules,
events or ceremonies.
-To use stipulation, description, analogy or figurative expression to remove
confusing, unintended vagueness or ambiguity, or to design a reasonable procedure for so
doing."}])

    @tree.initial_ct_question.ct_habilities.build(name: 'Análisis', description: "To identify the intended and actual inferential relationships among
statements, questions, concepts, descriptions or other forms of representation intended to
express beliefs, judgments, experiences, reasons, information, or opinions.", active: false, :ct_subhabilities_attributes =>[{name: 'Examinar ideas', description: "-To determine the role various expressions play or are intended to play in the
context of argument, reasoning or persuasion.
-To define terms.
-To compare or contrast ideas, concepts, or statements.
-To identify issues or problems and determine their component parts, and also to
identify the conceptual relationships of those parts to each other and to the whole."}, {name: 'Detectar argumentos', description: "Given a set of statements, descriptions, questions or graphic representations, to
determine whether or not the set expresses, or is intended to express, a reason or reasons
in support of or contesting some claim, opinion or point of view."}, {name: 'Analizar argumentos', description: "-Given the expression of a reason or reasons intended to support or contest some
claim, opinion or point of view, to identify and differentiate: 
(a) the intended main
conclusion
(b) the premises and reasons advanced in support of the main conclusion
(c) further premises and reasons advanced as backup or support for those premises and
reasons intended as supporting the main conclusion
(d) additional unexpressed elements
of that reasoning, such as intermediary conclusions, unstated assumptions or
presuppositions
(e) the overall structure of the argument or intended chain of reasoning
(f) any items contained in the body of expressions being examined which are not
intended to be taken as part of the reasoning being expressed or its intended background."}])

    @tree.initial_ct_question.ct_habilities.build(name: 'Evaluación', description: "To assess the credibility of statements or other representations which are
accounts or descriptions of a person's perception, experience, situation, judgment, belief,
or opinion; and to assess the logical strength of the actual or intend inferential relationships
among statements, descriptions, questions or other forms of representation.", active: false, :ct_subhabilities_attributes =>[{name: 'Evaluar demandas', description: "-To recognize the factors relevant to assessing the degree of credibility to ascribe
to a source of information or opinion.
-To assess the contextual relevance of questions, information, principles, rules or
procedural directions.
-To assess the acceptability, the level of confidence to place in the probability or
truth of any given representation of an experience, situation, judgment, belief or opinion."}, {name: 'Evaluar argumentos', description: "-To judge whether the assumed acceptability of the premises of a given argument
justify one's accepting as true (deductively certain), or very probably true (inductively
justified), the expressed conclusion of that argument.
-To anticipate or to raise questions or objections, and to assess whether these point
to significant weakness in the argument being evaluated.
-To determine whether an argument relies on false or doubtful assumptions or
presuppositions and then to determine how crucially these affect its strength.
-To judge between reasonable and fallacious inferences;
-To judge the probative strength of an argument's premises and assumptions with
a view toward determining the acceptability of the argument.
-To determine and judge the probative strength of an argument's intended or
unintended consequences with a view toward judging the acceptability of the argument;
-To determine the extent to which possible additional information might strengthen
or weaken an argument."}])

    @tree.initial_ct_question.ct_habilities.build(name: 'Inferencia', description: "To identify and secure elements needed to draw reasonable conclusions;
to form conjectures and hypotheses; to consider relevant information and to educe the
consequences flowing from data, statements, principles, evidence, judgments, beliefs,
opinions, concepts, descriptions, questions, or other forms of representation.", active: false, :ct_subhabilities_attributes =>[{name: 'Consultar evidencia', description: "-In particular, to recognize premises which require support and to formulate a
strategy for seeking and gathering information which might supply that support.
-In general, to judge that information relevant to deciding the acceptability,
plausibility or relative merits of a given alternative, question, issue, theory, hypothesis, or
statement is required, and to determine plausible
investigatory strategies for acquiring
that information."},
{name: 'Conjeturar alternativas', description: "-To formulate multiple alternatives for resolving a problem, to postulate a series of
suppositions regarding a question, to project alternative hypotheses regarding an event, to
develop a variety of different plans to achieve some goal.
-To draw out presuppositions and project the range of possible consequences of
decisions, positions, policies, theories, or beliefs."}, 
{name: 'Sacar conclusiones', description: "-To apply appropriate modes of inference in determining what position, opinion or
point of view one should take on a given matter or issue.
-Given a set of statements, descriptions, questions or other forms of representation,
to educe, with the proper level of logical strength, their inferential relationships and the
consequences or the presuppositions which they support, warrant, imply or entail.
-To employ successfully various sub-species of reasoning, as for example to reason
analogically, arithmetically, dialectically, scientifically, etc.
-To determine which of several possible conclusions is most strongly warranted or
supported by the evidence at hand, or which should be rejected
or regarded as less
plausible by the information given."}])

    @tree.initial_ct_question.ct_habilities.build(name: 'Explicación', description: "To state the results of one's reasoning; to justify that reasoning in terms
of the evidential, conceptual, methodological, criteriological and contextual considerations
upon which one's results were based; and to present one's reasoning in the form of cogent
arguments.", active: false, :ct_subhabilities_attributes =>[{name: 'Presentar resultados', description: "To produce accurate statements, descriptions or representations of the results of
one's reasoning activities so as to analyze, evaluate, infer from, or monitor those results."}, 
{name: 'Justificar procedimientos', description: "To present the evidential, conceptual, methodological, criteriological and contextual
considerations which one used in forming one's interpretations, analyses, evaluation or
inferences, so that one might accurately record, evaluate, describe or justify those
processes to one's self or to others, or so as to remedy perceived deficiencies in the general
way one executes those processes."}, {name: 'Presentar argumentos', description: "-To give reasons for accepting some claim.
-To meet objections to the method, conceptualizations, evidence, criteria or
contextual appropriateness of inferential, analytical or evaluative judgments"}])

   
   @tree.initial_ct_question.ct_habilities.build(name: 'Autoregulación', description: "Self-consciously to monitor one's cognitive activities, the elements
used in those activities, and the results educed, particularly by applying skills in analysis and
evaluation to one's own inferential judgments with a view toward questioning, confirming,
validating, or correcting either one's reasoning or one's results.", active: false, :ct_subhabilities_attributes =>[{name: 'Autoexaminación', description: "-To reflect on one's own reasoning and verify both the results produced and the
correct application and execution of the cognitive skills involved.
-To make an objective and thoughtful meta-cognitive self-assessment of one's
opinions and reasons for holding them.
-To judge the extent to which one's thinking is influenced by deficiencies in one's
knowledge, or by stereotypes, prejudices, emotions or any other factors which constrain
one's objectivity or rationality.
-To reflect on one's motivations, values, attitudes and interests with a view toward
determining that one has endeavored to be unbiased, fair-minded, thorough, objective, respectful of the truth, reasonable, and rational in coming to one's analyses, interpretations,
evaluations, inferences, or expressions."}, {name: 'Autocorreción', description: "Where self-examination reveals errors or deficiencies, to design reasonable
procedures to remedy or correct, if possible, those mistakes and their causes."}])



    #@recuperative_content_question = @tree.content_questions.build(:header => "recuperative_content_question")
    @tree.build_recuperative_content_question
    4.times { @tree.recuperative_content_question.content_choices.build }

    #@recuperative_ct_question = @tree.ct_questions.build(:header => "recuperative_ct_question")
    @tree.build_recuperative_ct_question
    4.times { @tree.recuperative_ct_question.ct_choices.build }
    @tree.recuperative_ct_question.ct_habilities.new(name: 'Interpretación', description: "To comprehend and express the meaning or significance of a wide
variety of experiences, situations, data, events, judgments, conventions, beliefs, rules,
procedures or criteria.", active: false, :ct_subhabilities_attributes => [{name: 'Categorización', description: "-To apprehend or appropriately formulate categories, distinctions, or frameworks
for understanding, describing or characterizing information.
-To describe experiences, situations, beliefs, events, etc. so that they take on
comprehensible meanings in terms of appropriate categorizations, distinctions, or
frameworks."}, {name: "Decodificar significado", description: "To detect, attend to, and describe the informational content, affective purport,
directive functions, intentions, motives, purposes, social significance, values, views, rules,
procedures, criteria, or inferential relationships expressed in convention-based
communication systems, such as in language, social behaviors, drawings, numbers, graphs,
tables, charts, signs and symbols."}, {name: 'Clarificar significados', description: "-To paraphrase or make explicit, through stipulation, description, analogy or
figurative expression, the contextual, conventional or intended meanings of words, ideas,
concepts, statements, behaviors, drawings, numbers, signs, charts, graphs, symbols, rules,
events or ceremonies.
-To use stipulation, description, analogy or figurative expression to remove
confusing, unintended vagueness or ambiguity, or to design a reasonable procedure for so
doing."}])

    @tree.recuperative_ct_question.ct_habilities.new(name: 'Análisis', description: "To identify the intended and actual inferential relationships among
statements, questions, concepts, descriptions or other forms of representation intended to
express beliefs, judgments, experiences, reasons, information, or opinions.", active: false, :ct_subhabilities_attributes =>[{name: 'Examinar ideas', description: "-To determine the role various expressions play or are intended to play in the
context of argument, reasoning or persuasion.
-To define terms.
-To compare or contrast ideas, concepts, or statements.
-To identify issues or problems and determine their component parts, and also to
identify the conceptual relationships of those parts to each other and to the whole."}, {name: 'Detectar argumentos', description: "Given a set of statements, descriptions, questions or graphic representations, to
determine whether or not the set expresses, or is intended to express, a reason or reasons
in support of or contesting some claim, opinion or point of view."}, {name: 'Analizar argumentos', description: "-Given the expression of a reason or reasons intended to support or contest some
claim, opinion or point of view, to identify and differentiate: 
(a) the intended main
conclusion
(b) the premises and reasons advanced in support of the main conclusion
(c) further premises and reasons advanced as backup or support for those premises and
reasons intended as supporting the main conclusion
(d) additional unexpressed elements
of that reasoning, such as intermediary conclusions, unstated assumptions or
presuppositions
(e) the overall structure of the argument or intended chain of reasoning
(f) any items contained in the body of expressions being examined which are not
intended to be taken as part of the reasoning being expressed or its intended background."}])

    @tree.recuperative_ct_question.ct_habilities.new(name: 'Evaluación', description: "To assess the credibility of statements or other representations which are
accounts or descriptions of a person's perception, experience, situation, judgment, belief,
or opinion; and to assess the logical strength of the actual or intend inferential relationships
among statements, descriptions, questions or other forms of representation.", active: false, :ct_subhabilities_attributes =>[{name: 'Evaluar demandas', description: "-To recognize the factors relevant to assessing the degree of credibility to ascribe
to a source of information or opinion.
-To assess the contextual relevance of questions, information, principles, rules or
procedural directions.
-To assess the acceptability, the level of confidence to place in the probability or
truth of any given representation of an experience, situation, judgment, belief or opinion."}, {name: 'Evaluar argumentos', description: "-To judge whether the assumed acceptability of the premises of a given argument
justify one's accepting as true (deductively certain), or very probably true (inductively
justified), the expressed conclusion of that argument.
-To anticipate or to raise questions or objections, and to assess whether these point
to significant weakness in the argument being evaluated.
-To determine whether an argument relies on false or doubtful assumptions or
presuppositions and then to determine how crucially these affect its strength.
-To judge between reasonable and fallacious inferences;
-To judge the probative strength of an argument's premises and assumptions with
a view toward determining the acceptability of the argument.
-To determine and judge the probative strength of an argument's intended or
unintended consequences with a view toward judging the acceptability of the argument;
-To determine the extent to which possible additional information might strengthen
or weaken an argument."}])

    @tree.recuperative_ct_question.ct_habilities.new(name: 'Inferencia', description: "To identify and secure elements needed to draw reasonable conclusions;
to form conjectures and hypotheses; to consider relevant information and to educe the
consequences flowing from data, statements, principles, evidence, judgments, beliefs,
opinions, concepts, descriptions, questions, or other forms of representation.", active: false, :ct_subhabilities_attributes =>[{name: 'Consultar evidencia', description: "-In particular, to recognize premises which require support and to formulate a
strategy for seeking and gathering information which might supply that support.
-In general, to judge that information relevant to deciding the acceptability,
plausibility or relative merits of a given alternative, question, issue, theory, hypothesis, or
statement is required, and to determine plausible
investigatory strategies for acquiring
that information."},
{name: 'Conjeturar alternativas', description: "-To formulate multiple alternatives for resolving a problem, to postulate a series of
suppositions regarding a question, to project alternative hypotheses regarding an event, to
develop a variety of different plans to achieve some goal.
-To draw out presuppositions and project the range of possible consequences of
decisions, positions, policies, theories, or beliefs."}, 
{name: 'Sacar conclusiones', description: "-To apply appropriate modes of inference in determining what position, opinion or
point of view one should take on a given matter or issue.
-Given a set of statements, descriptions, questions or other forms of representation,
to educe, with the proper level of logical strength, their inferential relationships and the
consequences or the presuppositions which they support, warrant, imply or entail.
-To employ successfully various sub-species of reasoning, as for example to reason
analogically, arithmetically, dialectically, scientifically, etc.
-To determine which of several possible conclusions is most strongly warranted or
supported by the evidence at hand, or which should be rejected
or regarded as less
plausible by the information given."}])

    @tree.recuperative_ct_question.ct_habilities.new(name: 'Explicación', description: "To state the results of one's reasoning; to justify that reasoning in terms
of the evidential, conceptual, methodological, criteriological and contextual considerations
upon which one's results were based; and to present one's reasoning in the form of cogent
arguments.", active: false, :ct_subhabilities_attributes =>[{name: 'Presentar resultados', description: "To produce accurate statements, descriptions or representations of the results of
one's reasoning activities so as to analyze, evaluate, infer from, or monitor those results."}, 
{name: 'Justificar procedimientos', description: "To present the evidential, conceptual, methodological, criteriological and contextual
considerations which one used in forming one's interpretations, analyses, evaluation or
inferences, so that one might accurately record, evaluate, describe or justify those
processes to one's self or to others, or so as to remedy perceived deficiencies in the general
way one executes those processes."}, {name: 'Presentar argumentos', description: "-To give reasons for accepting some claim.
-To meet objections to the method, conceptualizations, evidence, criteria or
contextual appropriateness of inferential, analytical or evaluative judgments"}])

   
   @tree.recuperative_ct_question.ct_habilities.new(name: 'Autoregulación', description: "Self-consciously to monitor one's cognitive activities, the elements
used in those activities, and the results educed, particularly by applying skills in analysis and
evaluation to one's own inferential judgments with a view toward questioning, confirming,
validating, or correcting either one's reasoning or one's results.", active: false, :ct_subhabilities_attributes =>[{name: 'Autoexaminación', description: "-To reflect on one's own reasoning and verify both the results produced and the
correct application and execution of the cognitive skills involved.
-To make an objective and thoughtful meta-cognitive self-assessment of one's
opinions and reasons for holding them.
-To judge the extent to which one's thinking is influenced by deficiencies in one's
knowledge, or by stereotypes, prejudices, emotions or any other factors which constrain
one's objectivity or rationality.
-To reflect on one's motivations, values, attitudes and interests with a view toward
determining that one has endeavored to be unbiased, fair-minded, thorough, objective, respectful of the truth, reasonable, and rational in coming to one's analyses, interpretations,
evaluations, inferences, or expressions."}, {name: 'Autocorreción', description: "Where self-examination reveals errors or deficiencies, to design reasonable
procedures to remedy or correct, if possible, those mistakes and their causes."}])

    #@deeping_content_question = @tree.content_questions.build(:header => "deeping_content_question")
    @tree.build_deeping_content_question
    4.times { @tree.deeping_content_question.content_choices.build }

    #@deeping_ct_question = @tree.ct_questions.build(:header => "deeping_ct_question")
    @tree.build_deeping_ct_question
    4.times { @tree.deeping_ct_question.ct_choices.build }
    @tree.deeping_ct_question.ct_habilities.new(name: 'Interpretación', description: "To comprehend and express the meaning or significance of a wide
variety of experiences, situations, data, events, judgments, conventions, beliefs, rules,
procedures or criteria.", active: false, :ct_subhabilities_attributes => [{name: 'Categorización', description: "-To apprehend or appropriately formulate categories, distinctions, or frameworks
for understanding, describing or characterizing information.
-To describe experiences, situations, beliefs, events, etc. so that they take on
comprehensible meanings in terms of appropriate categorizations, distinctions, or
frameworks."}, {name: "Decodificar significado", description: "To detect, attend to, and describe the informational content, affective purport,
directive functions, intentions, motives, purposes, social significance, values, views, rules,
procedures, criteria, or inferential relationships expressed in convention-based
communication systems, such as in language, social behaviors, drawings, numbers, graphs,
tables, charts, signs and symbols."}, {name: 'Clarificar significados', description: "-To paraphrase or make explicit, through stipulation, description, analogy or
figurative expression, the contextual, conventional or intended meanings of words, ideas,
concepts, statements, behaviors, drawings, numbers, signs, charts, graphs, symbols, rules,
events or ceremonies.
-To use stipulation, description, analogy or figurative expression to remove
confusing, unintended vagueness or ambiguity, or to design a reasonable procedure for so
doing."}])

    @tree.deeping_ct_question.ct_habilities.new(name: 'Análisis', description: "To identify the intended and actual inferential relationships among
statements, questions, concepts, descriptions or other forms of representation intended to
express beliefs, judgments, experiences, reasons, information, or opinions.", active: false, :ct_subhabilities_attributes =>[{name: 'Examinar ideas', description: "-To determine the role various expressions play or are intended to play in the
context of argument, reasoning or persuasion.
-To define terms.
-To compare or contrast ideas, concepts, or statements.
-To identify issues or problems and determine their component parts, and also to
identify the conceptual relationships of those parts to each other and to the whole."}, {name: 'Detectar argumentos', description: "Given a set of statements, descriptions, questions or graphic representations, to
determine whether or not the set expresses, or is intended to express, a reason or reasons
in support of or contesting some claim, opinion or point of view."}, {name: 'Analizar argumentos', description: "-Given the expression of a reason or reasons intended to support or contest some
claim, opinion or point of view, to identify and differentiate: 
(a) the intended main
conclusion
(b) the premises and reasons advanced in support of the main conclusion
(c) further premises and reasons advanced as backup or support for those premises and
reasons intended as supporting the main conclusion
(d) additional unexpressed elements
of that reasoning, such as intermediary conclusions, unstated assumptions or
presuppositions
(e) the overall structure of the argument or intended chain of reasoning
(f) any items contained in the body of expressions being examined which are not
intended to be taken as part of the reasoning being expressed or its intended background."}])

    @tree.deeping_ct_question.ct_habilities.new(name: 'Evaluación', description: "To assess the credibility of statements or other representations which are
accounts or descriptions of a person's perception, experience, situation, judgment, belief,
or opinion; and to assess the logical strength of the actual or intend inferential relationships
among statements, descriptions, questions or other forms of representation.", active: false, :ct_subhabilities_attributes =>[{name: 'Evaluar demandas', description: "-To recognize the factors relevant to assessing the degree of credibility to ascribe
to a source of information or opinion.
-To assess the contextual relevance of questions, information, principles, rules or
procedural directions.
-To assess the acceptability, the level of confidence to place in the probability or
truth of any given representation of an experience, situation, judgment, belief or opinion."}, {name: 'Evaluar argumentos', description: "-To judge whether the assumed acceptability of the premises of a given argument
justify one's accepting as true (deductively certain), or very probably true (inductively
justified), the expressed conclusion of that argument.
-To anticipate or to raise questions or objections, and to assess whether these point
to significant weakness in the argument being evaluated.
-To determine whether an argument relies on false or doubtful assumptions or
presuppositions and then to determine how crucially these affect its strength.
-To judge between reasonable and fallacious inferences;
-To judge the probative strength of an argument's premises and assumptions with
a view toward determining the acceptability of the argument.
-To determine and judge the probative strength of an argument's intended or
unintended consequences with a view toward judging the acceptability of the argument;
-To determine the extent to which possible additional information might strengthen
or weaken an argument."}])

    @tree.deeping_ct_question.ct_habilities.new(name: 'Inferencia', description: "To identify and secure elements needed to draw reasonable conclusions;
to form conjectures and hypotheses; to consider relevant information and to educe the
consequences flowing from data, statements, principles, evidence, judgments, beliefs,
opinions, concepts, descriptions, questions, or other forms of representation.", active: false, :ct_subhabilities_attributes =>[{name: 'Consultar evidencia', description: "-In particular, to recognize premises which require support and to formulate a
strategy for seeking and gathering information which might supply that support.
-In general, to judge that information relevant to deciding the acceptability,
plausibility or relative merits of a given alternative, question, issue, theory, hypothesis, or
statement is required, and to determine plausible
investigatory strategies for acquiring
that information."},
{name: 'Conjeturar alternativas', description: "-To formulate multiple alternatives for resolving a problem, to postulate a series of
suppositions regarding a question, to project alternative hypotheses regarding an event, to
develop a variety of different plans to achieve some goal.
-To draw out presuppositions and project the range of possible consequences of
decisions, positions, policies, theories, or beliefs."}, 
{name: 'Sacar conclusiones', description: "-To apply appropriate modes of inference in determining what position, opinion or
point of view one should take on a given matter or issue.
-Given a set of statements, descriptions, questions or other forms of representation,
to educe, with the proper level of logical strength, their inferential relationships and the
consequences or the presuppositions which they support, warrant, imply or entail.
-To employ successfully various sub-species of reasoning, as for example to reason
analogically, arithmetically, dialectically, scientifically, etc.
-To determine which of several possible conclusions is most strongly warranted or
supported by the evidence at hand, or which should be rejected
or regarded as less
plausible by the information given."}])

    @tree.deeping_ct_question.ct_habilities.new(name: 'Explicación', description: "To state the results of one's reasoning; to justify that reasoning in terms
of the evidential, conceptual, methodological, criteriological and contextual considerations
upon which one's results were based; and to present one's reasoning in the form of cogent
arguments.", active: false, :ct_subhabilities_attributes =>[{name: 'Presentar resultados', description: "To produce accurate statements, descriptions or representations of the results of
one's reasoning activities so as to analyze, evaluate, infer from, or monitor those results."}, 
{name: 'Justificar procedimientos', description: "To present the evidential, conceptual, methodological, criteriological and contextual
considerations which one used in forming one's interpretations, analyses, evaluation or
inferences, so that one might accurately record, evaluate, describe or justify those
processes to one's self or to others, or so as to remedy perceived deficiencies in the general
way one executes those processes."}, {name: 'Presentar argumentos', description: "-To give reasons for accepting some claim.
-To meet objections to the method, conceptualizations, evidence, criteria or
contextual appropriateness of inferential, analytical or evaluative judgments"}])

   
   @tree.deeping_ct_question.ct_habilities.new(name: 'Autoregulación', description: "Self-consciously to monitor one's cognitive activities, the elements
used in those activities, and the results educed, particularly by applying skills in analysis and
evaluation to one's own inferential judgments with a view toward questioning, confirming,
validating, or correcting either one's reasoning or one's results.", active: false, :ct_subhabilities_attributes =>[{name: 'Autoexaminación', description: "-To reflect on one's own reasoning and verify both the results produced and the
correct application and execution of the cognitive skills involved.
-To make an objective and thoughtful meta-cognitive self-assessment of one's
opinions and reasons for holding them.
-To judge the extent to which one's thinking is influenced by deficiencies in one's
knowledge, or by stereotypes, prejudices, emotions or any other factors which constrain
one's objectivity or rationality.
-To reflect on one's motivations, values, attitudes and interests with a view toward
determining that one has endeavored to be unbiased, fair-minded, thorough, objective, respectful of the truth, reasonable, and rational in coming to one's analyses, interpretations,
evaluations, inferences, or expressions."}, {name: 'Autocorreción', description: "Where self-examination reveals errors or deficiencies, to design reasonable
procedures to remedy or correct, if possible, those mistakes and their causes."}])

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

   
    #if params[:initialCT]
      #params[:initialCT].each do |hability|
        #if hability.to_s == "interpretation"
         # @tree.initial_ct_question.ct_habilities << CtHability.find_by(name: "Interpretación")
        #elsif hability.to_s == "analysis"
         # @tree.initial_ct_question.ct_habilities << CtHability.find_by(name: "Análisis")
        #elsif hability.to_s == "evaluation"
         # @tree.initial_ct_question.ct_habilities << CtHability.find_by(name: "Evaluación")
        #elsif hability.to_s == "inference"
         # @tree.initial_ct_question.ct_habilities << CtHability.find_by(name: "Inferencia")
        #elsif hability.to_s == "explanation"
         # @tree.initial_ct_question.ct_habilities << CtHability.find_by(name: "Explicación")
        #elsif hability.to_s == "selfregulation"
       #   @tree.initial_ct_question.ct_habilities << CtHability.find_by(name: "Autoregulación")
      #  end
     # end
    #end

    #if params[:recuperativeCT]
      #params[:recuperativeCT].each do |hability|
        #if hability.to_s == "interpretation"
         # @tree.recuperative_ct_question.ct_habilities << CtHability.find_by_name("Interpretación")
        #elsif hability.to_s == "analysis"
         # @tree.recuperative_ct_question.ct_habilities << CtHability.find_by_name("Análisis")
        #elsif hability.to_s == "evaluation"
         # @tree.recuperative_ct_question.ct_habilities << CtHability.find_by_name("Evaluación")
        #elsif hability.to_s == "inference"
         # @tree.recuperative_ct_question.ct_habilities << CtHability.find_by_name("Inferencia")
        #elsif hability.to_s == "explanation"
         # @tree.recuperative_ct_question.ct_habilities << CtHability.find_by_name("Explicación")
        #elsif hability.to_s == "selfregulation"
       #   @tree.recuperative_ct_question.ct_habilities << CtHability.find_by_name("Autoregulación")
      #  end
     # end
    #end

    #if params[:deepingCT]
      #params[:deepingCT].each do |hability|
        #if hability.to_s == "interpretation"
         # @tree.deeping_ct_question.ct_habilities << CtHability.find_by_name("Interpretación")
        #elsif hability.to_s == "analysis"
         # @tree.deeping_ct_question.ct_habilities << CtHability.find_by_name("Análisis")
        #elsif hability.to_s == "evaluation"
         # @tree.deeping_ct_question.ct_habilities << CtHability.find_by_name("Evaluación")
        #elsif hability.to_s == "inference"
         # @tree.deeping_ct_question.ct_habilities << CtHability.find_by_name("Inferencia")
        #elsif hability.to_s == "explanation"
         # @tree.deeping_ct_question.ct_habilities << CtHability.find_by_name("Explicación")
        #elsif hability.to_s == "selfregulation"
       #   @tree.deeping_ct_question.ct_habilities << CtHability.find_by_name("Autoregulación")
      #  end
     # end
    #end


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
