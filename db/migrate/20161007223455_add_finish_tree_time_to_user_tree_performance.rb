class AddFinishTreeTimeToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :finish_tree_time, :datetime
  end
end
