class AddDeepingFb2TimeToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :deeping_fb2_time, :float
  end
end
