class AddDateGenerationUnitsToReleases < ActiveRecord::Migration[5.1]
  def change
    add_column :water_releases, :date, :date
    add_column :water_releases, :generation, :boolean, default: false, null: false
    add_column :water_releases, :units, :integer
  end
end
