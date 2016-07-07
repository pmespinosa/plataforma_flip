class CreateHomeworksQuestionsJoin < ActiveRecord::Migration
  def change
    create_table :homeworks_questions, :id => false do |t|
      t.integer "homework_id"
      t.integer "question_id"
    end
    add_index :homeworks_questions, ["homework_id", "question_id"]
  end
end
