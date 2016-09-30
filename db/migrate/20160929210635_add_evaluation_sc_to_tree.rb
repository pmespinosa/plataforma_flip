class AddEvaluationScToTree < ActiveRecord::Migration
  def change
    add_column :trees, :evaluation_sc, :float
  end
end
