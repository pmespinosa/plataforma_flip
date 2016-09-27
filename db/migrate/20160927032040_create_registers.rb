class CreateRegisters < ActiveRecord::Migration
  def change
    create_table :registers do |t|
      t.integer :button_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
