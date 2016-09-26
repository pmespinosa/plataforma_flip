class AddAttachmentImageToAnswers < ActiveRecord::Migration
  def self.up
    change_table :answers do |t|
      t.attachment :image_responder
      t.attachment :image_argumentar
      t.attachment :image_rehacer
      t.attachment :image_evaluar
      t.attachment :image_final

    end
  end

  def self.down
    remove_attachment :answers, :image
  end
end
