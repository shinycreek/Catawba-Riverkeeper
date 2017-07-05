class UserSetting < ApplicationRecord
  has_many :trash_loggers, :foreign_key => :phone_id, :primary_key => :phone_id
end
