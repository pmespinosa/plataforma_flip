class AddSelfregulationNToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :selfregulation_n, :integer
  end
end
