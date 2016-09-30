class AddInferenceNToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :inference_n, :integer
  end
end
