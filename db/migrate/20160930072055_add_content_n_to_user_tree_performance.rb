class AddContentNToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :content_n, :integer
  end
end
