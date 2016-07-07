# == Schema Information
#
# Table name: activities
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  actual_phase :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Activity < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :questions
  has_many :key_words
end
