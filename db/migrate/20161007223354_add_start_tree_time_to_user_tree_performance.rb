class AddStartTreeTimeToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :start_tree_time, :datetime
  end
end
