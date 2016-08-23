class CreateCtChoices < ActiveRecord::Migration
  def change
    create_table :ct_choices do |t|
      t.text :text
      t.boolean :right
      t.references :ct_question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
