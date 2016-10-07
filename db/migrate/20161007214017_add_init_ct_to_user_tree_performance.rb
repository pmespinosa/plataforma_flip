class AddInitCtToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :init_ct, :float
  end
end
