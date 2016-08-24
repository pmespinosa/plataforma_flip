class CreateContentChoices < ActiveRecord::Migration
  def change
    create_table :content_choices do |t|
      t.text :text
      t.boolean :right
      t.references :content_question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
