class AddAnalysisScToTree < ActiveRecord::Migration
  def change
    add_column :trees, :analysis_sc, :float
  end
end
