class Report < ActiveRecord::Base
  belongs_to :course
  has_many :trees
end
