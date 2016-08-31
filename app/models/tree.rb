class Tree < ActiveRecord::Base

  belongs_to :course
  has_one :content
  has_many :content_questions
  has_many :ct_questions
  has_one :initial_content_question, :class_name => "ContentQuestion"
  has_one :initial_ct_question, :class_name => "CtQuestion"
  has_one :recuperative_content_question, :class_name => "ContentQuestion"
  has_one :recuperative_ct_question, :class_name => "CtQuestion"
  has_one :deeping_content_question, :class_name => "ContentQuestion"
  has_one :deeping_ct_question, :class_name => "CtQuestion"
  has_many :feedbacks
  has_many :content_choices, through: :content_questions
  has_many :ct_choices, through: :ct_questions
  accepts_nested_attributes_for :content, :reject_if => lambda { |a| a[:text].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :content_questions, :reject_if => lambda { |a| a[:question].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :ct_questions, :reject_if => lambda { |a| a[:question].blank? }, :allow_destroy => true

  accepts_nested_attributes_for :initial_content_question, :reject_if => lambda { |a| a[:question].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :initial_ct_question, :reject_if => lambda { |a| a[:question].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :recuperative_content_question, :reject_if => lambda { |a| a[:question].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :recuperative_ct_question, :reject_if => lambda { |a| a[:question].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :deeping_content_question, :reject_if => lambda { |a| a[:question].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :deeping_ct_question, :reject_if => lambda { |a| a[:question].blank? }, :allow_destroy => true
  
end
