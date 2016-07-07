# == Schema Information
#
# Table name: key_words
#
#  id          :integer          not null, primary key
#  content     :string(255)
#  activity_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class KeyWord < ActiveRecord::Base
  belongs_to :activity
end
