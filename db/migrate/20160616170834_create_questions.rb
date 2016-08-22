class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :phase
      t.string :content
      t.timestamps null: false
      t.integer :anterior
    end
  end
end
