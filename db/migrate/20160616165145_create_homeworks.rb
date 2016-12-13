class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.text :name
      t.text :content
      t.integer :actual_phase
      t.boolean :upload
      t.boolean :current
      t.integer :course_id
      t.timestamps null: false
    end
  end
end
