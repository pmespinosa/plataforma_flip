class AddRecuperativeFb2TimeToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :recuperative_fb2_time, :float
  end
end
