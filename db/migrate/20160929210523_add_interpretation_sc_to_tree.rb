class AddInterpretationScToTree < ActiveRecord::Migration
  def change
    add_column :trees, :interpretation_sc, :float
  end
end
