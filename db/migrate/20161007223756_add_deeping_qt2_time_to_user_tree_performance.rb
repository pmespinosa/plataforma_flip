class AddDeepingQt2TimeToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :deeping_qt2_time, :float
  end
end
