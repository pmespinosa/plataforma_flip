class ContentQuestion < ActiveRecord::Base
  belongs_to :tree
  has_many :content_choices
  accepts_nested_attributes_for :content_choices, :reject_if => lambda { |a| a[:text].blank? }, :allow_destroy => true
end
