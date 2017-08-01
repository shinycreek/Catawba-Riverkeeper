# == Schema Information
#
# Table name: lakes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lake < ApplicationRecord
  has_many :lake_levels, dependent: :destroy
end
