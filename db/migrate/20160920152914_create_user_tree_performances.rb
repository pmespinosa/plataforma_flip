class CreateUserTreePerformances < ActiveRecord::Migration
  def change
    create_table :user_tree_performances do |t|
      t.references :user, index: true, foreign_key: true
      t.references :tree, index: true, foreign_key: true
      t.float :content_sc
      t.float :interpretation_sc
      t.float :analysis_sc
      t.float :evaluation_sc
      t.float :inference_sc
      t.float :explanation_sc
      t.float :selfregulation_sc

      t.timestamps null: false
    end
  end
end
