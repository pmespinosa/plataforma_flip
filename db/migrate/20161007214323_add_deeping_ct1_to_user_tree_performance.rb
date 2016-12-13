class AddDeepingCt1ToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :deeping_ct1, :float
  end
end
