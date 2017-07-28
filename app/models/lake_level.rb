# == Schema Information
#
# Table name: lake_levels
#
#  id         :integer          not null, primary key
#  lake_name  :string
#  level      :float
#  target     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LakeLevel < ApplicationRecord
end
