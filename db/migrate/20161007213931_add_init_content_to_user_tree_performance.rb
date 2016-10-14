class AddInitContentToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :init_content, :float
  end
end
