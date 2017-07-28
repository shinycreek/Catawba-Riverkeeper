# == Schema Information
#
# Table name: trash_loggers
#
#  id                :integer          not null, primary key
#  describe_trash    :text
#  describe_location :text
#  adjacent_waterway :text
#  phone_id          :string
#  latitude          :string
#  longitude         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class TrashLoggerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
