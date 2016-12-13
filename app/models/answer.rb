# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :string(500)
#  upload      :boolean          default(FALSE)
#  user_id     :integer
#  question_id :integer
#  question_phase :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  phase       :integer

class Answer < ActiveRecord::Base
  enum phase: [:responder, :argumentar, :rehacer, :responder_2, :argumentar_2, :rehacer_2]
  after_initialize :set_default_actual_phase, :if => :new_record?

  def set_default_actual_phase
    self.phase ||= :responder
  end

  belongs_to :user
  belongs_to :homework
  has_attached_file :image_responder, styles: {medium: "800x800>"}
  has_attached_file :image_argumentar, styles: {medium: "800x800>"}
  has_attached_file :image_rehacer, styles: {medium: "800x800>"}
  has_attached_file :image_responder_2, styles: {medium: "800x800>"}
  has_attached_file :image_argumentar_2, styles: {medium: "800x800>"}
  has_attached_file :image_rehacer_2, styles: {medium: "800x800>"}
  validates_attachment_content_type :image_responder, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]
  validates_attachment_content_type :image_argumentar, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]
  validates_attachment_content_type :image_rehacer, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]
  validates_attachment_content_type :image_responder_2, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]
  validates_attachment_content_type :image_argumentar_2, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]
  validates_attachment_content_type :image_rehacer_2, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]
end
