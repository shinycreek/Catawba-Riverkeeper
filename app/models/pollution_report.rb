class PollutionReport < ApplicationRecord

  has_many :upload_images, as: :imageable
  accepts_nested_attributes_for :upload_images

end
