class CreateCtQuestions < ActiveRecord::Migration
  def change
    create_table :ct_questions do |t|
      t.text :question
      t.references :tree, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
