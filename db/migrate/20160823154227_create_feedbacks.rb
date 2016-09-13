class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :text
      t.references :tree, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
