class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.string :name
      t.integer :actual_phase
      t.boolean :upload

      t.timestamps null: false
    end
  end
end
