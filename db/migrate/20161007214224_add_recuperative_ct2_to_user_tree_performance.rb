class AddRecuperativeCt2ToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :recuperative_ct2, :float
  end
end
