class AddAttachmentImageToAnswers < ActiveRecord::Migration
  def self.up
    change_table :answers do |t|
      t.attachment :image_responder_1
      t.attachment :image_responder_2
      t.attachment :image_argumentar_1
      t.attachment :image_argumentar_2
      t.attachment :image_rehacer_1
      t.attachment :image_rehacer_2
      t.attachment :image_evaluar_1
      t.attachment :image_evaluar_2
      t.attachment :image_integrar_1
      t.attachment :image_integrar_2

    end
  end

  def self.down
     remove_attachment :answers, :image_responder_1
     remove_attachment :answers, :image_responder_2
     remove_attachment :answers, :image_argumentar_1
     remove_attachment :answers, :image_argumentar_2
     remove_attachment :answers, :image_rehacer_1
     remove_attachment :answers, :image_rehacer_2
     remove_attachment :answers, :image_evaluar_1
     remove_attachment :answers, :image_evaluar_2
     remove_attachment :answers, :image_integrar_1
     remove_attachment :answers, :image_integrar_2
  end
end
