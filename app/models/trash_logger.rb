class TrashLogger < ApplicationRecord

  has_many :trash_logger_images
  belongs_to :user_setting, :foreign_key => :phone_id, :primary_key => :phone_id, optional: true

  accepts_nested_attributes_for :trash_logger_images

end
