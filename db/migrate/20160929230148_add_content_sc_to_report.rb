class AddContentScToReport < ActiveRecord::Migration
  def change
    add_column :reports, :content_sc, :float
  end
end
