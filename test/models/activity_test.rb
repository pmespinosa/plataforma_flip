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

require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
