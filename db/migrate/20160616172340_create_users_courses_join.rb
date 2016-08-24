class CreateUsersCoursesJoin < ActiveRecord::Migration
  def change
    create_table :users_courses, :id => false do |t|
<<<<<<< HEAD
=======
<<<<<<< HEAD
      t.integer "user_id"
      t.integer "course_id"
    end
    add_index :users_courses, ["user_id", "course_id"]
=======
      t.integer "courses_id"
>>>>>>> desarrollo-de-cursos
      t.integer "user_id"
      t.integer "courses_id"
    end
    add_index :users_courses, ["user_id", "courses_id"]
>>>>>>> master
  end
end
