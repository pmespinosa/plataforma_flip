class AddRecuperativeQt2TimeToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :recuperative_qt2_time, :float
  end
end
