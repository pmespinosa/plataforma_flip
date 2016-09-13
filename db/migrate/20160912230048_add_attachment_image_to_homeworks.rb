class AddAttachmentImageToHomeworks < ActiveRecord::Migration
  def self.up
    change_table :homeworks do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :homeworks, :image
  end
end
