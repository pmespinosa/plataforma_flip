class AddInferenceScToTree < ActiveRecord::Migration
  def change
    add_column :trees, :inference_sc, :float
  end
end
