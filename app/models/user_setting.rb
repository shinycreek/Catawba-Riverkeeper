# == Schema Information
#
# Table name: user_settings
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  email      :string
#  phone      :string
#  country    :string
#  address    :string
#  city       :string
#  state      :string(2)
#  zip        :string
#  phone_id   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserSetting < ApplicationRecord
  has_many :trash_loggers, :foreign_key => :phone_id, :primary_key => :phone_id
end
