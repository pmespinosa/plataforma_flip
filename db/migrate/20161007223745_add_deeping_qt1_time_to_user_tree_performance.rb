class AddDeepingQt1TimeToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :deeping_qt1_time, :float
  end
end
