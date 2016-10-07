class AddDeepingContent2ToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :deeping_content2, :float
  end
end
