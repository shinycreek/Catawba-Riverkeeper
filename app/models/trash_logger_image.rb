class TrashLoggerImage < ApplicationRecord
  belongs_to :trash_logger
  mount_base64_uploader :image, ImageUploader
end
