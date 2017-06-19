class Website < ApplicationRecord
  enum website_type: { basinmap: "basinmap", crf: "crf" }

  validates :url, presence: true, :url => true
  validates :website_type, uniqueness: true
end