# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#User.destroy_all
#Course.destroy_all
#Content.destroy_all

User.create(first_name: 'Harold', last_name: 'Muller', email: 'hlmuller@uc.cl', role: 2, password: '123456', asistencia: false)
User.create(first_name: 'Pablo', last_name: 'Espinosa', email: 'pespinosa@uc.cl', role: 2, password: '123456', asistencia: false)
User.create(first_name: 'Vicente', last_name: 'Martin', email: 'vrmartin@uc.cl', role: 2, password: '123456', asistencia: false)
User.create(first_name: 'Vicente', last_name: 'Martin', email: 'vicentemartintarud@gmail.com', role: 0, password: '123456', asistencia: false)
User.create(first_name: 'Miguel', last_name: 'Nussbaum', email: 'mn@uc.cl', role: 0, password: '123456', asistencia: false)
User.create(first_name: 'Catalina', last_name: 'Martin', email: 'cata_martin@gmail.com', role: 0, password: '123456', asistencia: false)
User.create(first_name: 'Camila', last_name: 'Martin', email: 'cami_martin@gmail.com', role: 0, password: '123456', asistencia: false)
User.create(first_name: 'Patricia', last_name: 'Garcia', email: 'pgh@gmail.com', role: 0, password: '123456', asistencia: false)
Course.create(name: "Didáctica de las matemáticas I", description: "Curso de la facultad de educación, donde se estudian métodos y bla bla bla")
Course.create(name: "Didáctica de las matemáticas II", description: "Curso de la facultad de educación, es la continuación de didáctica de las matemáticas I y bla bla bla")


#arbol1 = Tree.create!(video: "https://www.youtube.com/watch?v=69EQUcUpRxo", iterations: 1)
#arbol1.content = Content.new(text: "Tarea Matemática")

#arbol2 = Tree.create!(video: "https://www.youtube.com/watch?v=uhBHL3v4d3I", iterations: 1)
#arbol2.content = Content.new(text: "Tipos de Tarea")	

#arbol3 = Tree.create!(video: "https://www.youtube.com/watch?v=WM8bTdBs-cw", iterations: 1)
#arbol3.content = Content.new(text: "Problemas matemáticos")

course1 = Course.find_by name: "Didáctica de las matemáticas I" 

#course1.trees[0] = arbol1
#course1.trees.build(arbol4)
#course1.trees.build(arbol3)

content1 = Content.new(text: "Tarea Matemática")
content2 = Content.new(text: "Tipos de Tarea")	
content3 = Content.new(text: "Problemas matemáticos")




the_ct_question = Ct_question.new(text: "pregunta pensamiento crítico")
the_content_question = Content_question.new(text: "pregunta contenido")

the_content_question.content_choices.create![

	{text: "alternativa a", right: false},
	{text: "alternativa b", right: false},
	{text: "alternativa c", right: true}
]

the_ct_question.ct_choices.create![

	{text: "alternativa a", right: false},
	{text: "alternativa b", right: false},
	{text: "alternativa c", right: true},
	{text: "alternativa d", right: true}

]

course1.trees.create! [
	{video: "https://www.youtube.com/watch?v=69EQUcUpRxo",iterations: 1, content: content1,
		ct_question: the_ct_question, content_choices: the_content_question},	
	{video: "https://www.youtube.com/watch?v=uhBHL3v4d3I",iterations: 1, content: content2,
		ct_question: the_ct_question, content_choices: the_content_question},
	{video: "https://www.youtube.com/watch?v=WM8bTdBs-cw",iterations: 1, content: content3, 
		ct_question: the_ct_question, content_choices: the_content_question}
]