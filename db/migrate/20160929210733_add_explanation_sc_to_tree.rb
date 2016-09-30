class AddExplanationScToTree < ActiveRecord::Migration
  def change
    add_column :trees, :explanation_sc, :float
  end
end
