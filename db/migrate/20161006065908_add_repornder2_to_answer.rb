class AddRepornder2ToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :responder_2, :text
  end
end
