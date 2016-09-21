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
  enum phase: [:responder, :argumentar, :rehacer, :evaluar, :final]
  after_initialize :set_default_actual_phase, :if => :new_record?

  def set_default_actual_phase
    self.phase ||= :responder
  end

  belongs_to :user
  belongs_to :homework
  has_attached_file :image, styles: {medium: "800x800>"}
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]
end
