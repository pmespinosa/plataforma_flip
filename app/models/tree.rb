class Tree < ActiveRecord::Base

  belongs_to :course
  has_one :content
  has_many :content_questions
  has_many :ct_questions
  has_many :feedbacks
  has_many :content_choices, through: :content_questions
  has_many :ct_choices, through: :ct_questions
  
end
