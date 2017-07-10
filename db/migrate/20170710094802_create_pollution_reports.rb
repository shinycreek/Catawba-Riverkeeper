class CreatePollutionReports < ActiveRecord::Migration[5.1]
  def change
    create_table :pollution_reports do |t|
      t.text :describe_pollution
      t.text :describe_location
      t.text :adjacent_area
      t.string :phone_id
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
