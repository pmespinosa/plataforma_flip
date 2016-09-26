class CtQuestion < ActiveRecord::Base
  belongs_to :tree
  has_many :ct_choices, :dependent => :destroy
  has_and_belongs_to_many :ct_habilities
  accepts_nested_attributes_for :ct_choices, :reject_if => lambda { |a| a[:text].blank? }, :allow_destroy => true
end
