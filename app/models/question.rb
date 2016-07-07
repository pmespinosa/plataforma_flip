class Question < ActiveRecord::Base
  has_and_belongs_to_many :homeworks
  has_many :answers
end
