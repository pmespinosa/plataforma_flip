class CreateUsersCoursesJoin < ActiveRecord::Migration
  def change
    create_table :users_courses, :id => false do |t|
      t.integer "courses_id"
      t.integer "user_id"
    end
    add_index :users_courses, ["user_id", "courses_id"]
  end
end
