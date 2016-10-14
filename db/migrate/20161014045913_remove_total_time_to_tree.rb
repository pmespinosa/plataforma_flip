class RemoveTotalTimeToTree < ActiveRecord::Migration
  def change
    remove_column :trees, :total_time, :integer
  end
end
