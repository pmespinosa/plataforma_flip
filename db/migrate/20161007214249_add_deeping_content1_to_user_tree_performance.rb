class AddDeepingContent1ToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :deeping_content1, :float
  end
end
