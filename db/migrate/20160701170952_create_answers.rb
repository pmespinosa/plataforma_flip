class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer "user_id"
      t.integer "homework_id"
      t.integer "phase"
      t.text "responder"
      t.text "argumentar"
      t.text "rehacer"
      t.text "evaluar"
      t.text "final"
      t.timestamps null: false
    end
    add_index :answers, ["user_id", "homework_id"]
  end
end
