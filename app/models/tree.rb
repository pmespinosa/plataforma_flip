class Tree < ActiveRecord::Base

  belongs_to :course
  has_one :content
  has_many :content_quiestions
  has_many :ct_cuestions
  has_many :feedbacks
  has_many :content_choices, through: :content_quiestions
  has_many :ct_choices, through: :ct_quiestions
  
end
