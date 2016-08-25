class Question < ActiveRecord::Base
  enum phase: [:responder, :argumentar, :rehacer]

  has_and_belongs_to_many :homeworks
  has_many :answers
end
