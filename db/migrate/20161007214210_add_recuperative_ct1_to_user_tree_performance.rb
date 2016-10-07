class AddRecuperativeCt1ToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :recuperative_ct1, :float
  end
end
