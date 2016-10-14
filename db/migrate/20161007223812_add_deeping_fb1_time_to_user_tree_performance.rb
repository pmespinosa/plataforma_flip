class AddDeepingFb1TimeToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :deeping_fb1_time, :float
  end
end
