class AddRecuperativeQt1TimeToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :recuperative_qt1_time, :float
  end
end
