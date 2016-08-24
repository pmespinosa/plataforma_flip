class CreateUsersCoursesJoin < ActiveRecord::Migration
  def change
    create_table :users_courses, :id => false do |t|
      t.integer "user_id"
      t.integer "courses_id"
    end
    add_index :users_courses, ["user_id", "courses_id"]
  end
end
