class AddTotalTimeToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :total_time, :integer
  end
end
