class Tree < ActiveRecord::Base

  belongs_to :course
  has_one :content
  has_many :content_questions
  has_many :ct_questions
  has_many :feedbacks
  has_many :content_choices, through: :content_questions
  has_many :ct_choices, through: :ct_questions
  accepts_nested_attributes_for :content, :reject_if => lambda { |a| a[:text].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :content_questions, :reject_if => lambda { |a| a[:question].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :ct_questions, :reject_if => lambda { |a| a[:question].blank? }, :allow_destroy => true
  
end
