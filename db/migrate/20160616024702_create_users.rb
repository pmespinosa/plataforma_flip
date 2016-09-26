class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "first_name"
      t.string "last_name"
      t.integer "role"
      t.boolean "asistencia"
      t.integer "partner_id"
      t.integer "current_course_id", :default => 0 #agregue default para eliminar nil
      t.datetime "last_asistencia", :default => "2016-01-01 12:00:00.000000"
      t.integer "last_homework"
      t.timestamps null: false
    end
  end
end
