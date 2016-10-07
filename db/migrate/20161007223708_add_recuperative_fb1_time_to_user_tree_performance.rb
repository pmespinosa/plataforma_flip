class AddRecuperativeFb1TimeToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :recuperative_fb1_time, :float
  end
end
