class CtQuestion < ActiveRecord::Base
  belongs_to :tree
  has_many :ct_choices
  has_many :ct_habilities
end
