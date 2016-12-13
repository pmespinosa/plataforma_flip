class AddRecuperativeContent1ToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :recuperative_content1, :float
  end
end
