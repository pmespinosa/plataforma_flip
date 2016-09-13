class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :text
      t.references :tree, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
