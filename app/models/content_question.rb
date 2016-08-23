class ContentQuestion < ActiveRecord::Base
  belongs_to :tree
  has_many :content_choices
end
