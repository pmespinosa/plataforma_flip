class CreateJoinTableReportTree < ActiveRecord::Migration
  def change
    create_join_table :reports, :trees do |t|
      # t.index [:report_id, :tree_id]
      # t.index [:tree_id, :report_id]
    end
  end
end
