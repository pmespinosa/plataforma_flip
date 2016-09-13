class CreateCtSubhabilities < ActiveRecord::Migration
  def change
    create_table :ct_subhabilities do |t|
      t.string :name
      t.text :description
      t.references :ct_hability, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
