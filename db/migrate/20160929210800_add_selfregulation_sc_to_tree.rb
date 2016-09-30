class AddSelfregulationScToTree < ActiveRecord::Migration
  def change
    add_column :trees, :selfregulation_sc, :float
  end
end
