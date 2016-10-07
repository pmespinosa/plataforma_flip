class AddInitFbTimeToUserTreePerformance < ActiveRecord::Migration
  def change
    add_column :user_tree_performances, :init_fb_time, :float
  end
end
