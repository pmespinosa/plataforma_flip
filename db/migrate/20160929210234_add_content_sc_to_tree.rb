class AddContentScToTree < ActiveRecord::Migration
  def change
    add_column :trees, :content_sc, :float
  end
end
