class Homework < ActiveRecord::Base

  enum actual_phase: [:responder, :argumentar, :rehacer]
  after_initialize :set_default_actual_phase, :if => :new_record?

  def set_default_actual_phase
    self.actual_phase ||= :responder
  end

  has_and_belongs_to_many :users
  has_and_belongs_to_many :questions
  has_many :key_words
  has_many :answers
  belongs_to :course
end
