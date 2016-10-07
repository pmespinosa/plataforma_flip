class AddDeepingCt2ToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :deeping_ct2, :float
  end
end
