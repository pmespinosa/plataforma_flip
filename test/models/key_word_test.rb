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

require 'test_helper'

class KeyWordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
