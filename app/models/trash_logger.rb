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

class TrashLogger < ApplicationRecord

  belongs_to :user_setting, :foreign_key => :phone_id, :primary_key => :phone_id, optional: true
  has_many :upload_images, as: :imageable
  accepts_nested_attributes_for :upload_images

end
