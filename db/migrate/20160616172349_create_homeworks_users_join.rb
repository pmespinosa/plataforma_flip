class CreateHomeworksUsersJoin < ActiveRecord::Migration
  def change
    create_table :homeworks_users, :id => false do |t|
      t.integer "homework_id"
      t.integer "user_id"
      t.integer "course_id"
    end
    add_index :homeworks_users, ["homework_id", "user_id"]
  end
end
