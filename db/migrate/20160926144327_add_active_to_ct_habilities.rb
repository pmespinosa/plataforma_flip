class AddActiveToCtHabilities < ActiveRecord::Migration
  def change
    add_column :ct_habilities, :active, :boolean
  end
end
