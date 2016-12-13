class RemoveNToUserTreePerformance < ActiveRecord::Migration
  def change
    remove_column :user_tree_performances, :n, :integer
  end
end
