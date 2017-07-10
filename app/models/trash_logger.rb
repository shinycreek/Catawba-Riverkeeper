class TrashLogger < ApplicationRecord

  belongs_to :user_setting, :foreign_key => :phone_id, :primary_key => :phone_id, optional: true
  has_many :upload_images, as: :imageable
  accepts_nested_attributes_for :upload_images

end
