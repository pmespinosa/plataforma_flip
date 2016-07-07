class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer "user_id"
      t.integer "question_id"
      t.text "content"
      t.timestamps null: false
    end
    add_index :answers, ["user_id", "question_id"]
  end
end
