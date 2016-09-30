class AddAnalysisNToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :analysis_n, :integer
  end
end
