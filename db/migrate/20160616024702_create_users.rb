class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "first_name"
      t.string "last_name"
      t.integer "role"
      t.boolean "asistencia"
      t.integer "partner_id"
      t.integer "current_course_id"
      t.timestamps null: false
    end
  end
end
