class AddRehacer2ToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :rehacer_2, :text
  end
end
