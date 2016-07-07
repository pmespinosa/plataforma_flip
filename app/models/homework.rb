class Homework < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :questions
  has_many :key_words
  has_many :answers
end
