class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer "user_id"
      t.integer "corrector_id", :default => 0
      t.integer "homework_id"
      t.text "phase"
      t.text "responder"
      t.text "argumentar"
      t.text "rehacer"
      t.text "evaluar"
      t.text "integrar"
      t.timestamps null: false
    end
    add_index :answers, ["user_id", "homework_id"]
  end
end
