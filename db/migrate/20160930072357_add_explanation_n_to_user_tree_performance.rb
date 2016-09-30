class AddExplanationNToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :explanation_n, :integer
  end
end
