class AddRecuperativeContent2ToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :recuperative_content2, :float
  end
end
