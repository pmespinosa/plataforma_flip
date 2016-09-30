class AddEvaluationNToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :evaluation_n, :integer
  end
end
