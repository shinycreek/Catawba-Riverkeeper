class AddNewsToLakeLevels < ActiveRecord::Migration[5.1]
  def change
    add_column :lake_levels, :news, :datetime
  end
end
