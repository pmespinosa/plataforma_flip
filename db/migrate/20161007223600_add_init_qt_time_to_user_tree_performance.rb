class AddInitQtTimeToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :init_qt_time, :float
  end
end
