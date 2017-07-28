# == Schema Information
#
# Table name: lake_levels
#
#  id            :integer          not null, primary key
#  level         :float
#  target        :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  lake_id       :integer
#  date_recorded :date
#

class LakeLevel < ApplicationRecord
  belongs_to :lake
  validates :lake_id, presence: true
  delegate :name, to: :lake, prefix: true

  scope :by_date_recorded, -> { order(:date_recorded) }
end
