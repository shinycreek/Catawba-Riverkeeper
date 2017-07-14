class CreateWaterReleases < ActiveRecord::Migration[5.1]
  def change
    create_table :water_releases do |t|
      t.references :dam
      t.datetime :start_at
      t.datetime :stop_at

      t.timestamps
    end
  end
end
