# == Schema Information
#
# Table name: upload_images
#
#  id             :integer          not null, primary key
#  image          :string
#  imageable_id   :integer
#  imageable_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class UploadImage < ApplicationRecord

  mount_base64_uploader :image, ImageUploader
  belongs_to :imageable, polymorphic: true, optional: true
  
end
