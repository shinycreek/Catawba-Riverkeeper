# == Schema Information
#
# Table name: lakes
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  api_lake_id :integer
#

require 'test_helper'

class LakeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
