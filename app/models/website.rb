# == Schema Information
#
# Table name: websites
#
#  id           :integer          not null, primary key
#  url          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  website_type :string
#

class Website < ApplicationRecord
  enum website_type: {
    basinmap: "basinmap",
    crf: "crf",
    facebook: "facebook",
    instagram: "instagram",
    twitter: "twitter"
  }

  validates :url, presence: true, :url => true
  validates :website_type, uniqueness: true

  scope :by_website_type,->(type) { where(website_type: type.to_s.to_sym) }
end
