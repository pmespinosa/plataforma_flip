class Course < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :homeworks
  has_many :trees
end
