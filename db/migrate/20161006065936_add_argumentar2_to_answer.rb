class AddArgumentar2ToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :argumentar_2, :text
  end
end
