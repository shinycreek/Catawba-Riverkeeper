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
end