class AddNToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :n, :integer
  end
end
