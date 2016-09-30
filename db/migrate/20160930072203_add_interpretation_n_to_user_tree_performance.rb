class AddInterpretationNToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :interpretation_n, :integer
  end
end
