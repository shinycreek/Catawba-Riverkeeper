class UploadImage < ApplicationRecord

	mount_base64_uploader :image, ImageUploader
	belongs_to :imageable, polymorphic: true, optional: true
	
end
