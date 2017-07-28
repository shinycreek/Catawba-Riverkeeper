# == Schema Information
#
# Table name: websites
#
#  id           :integer          not null, primary key
#  url          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  website_type :string
#

require 'test_helper'

class WebsiteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
