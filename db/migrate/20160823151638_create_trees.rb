class CreateTrees < ActiveRecord::Migration
  def change
    create_table :trees do |t|
      t.string :video
      t.references :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
