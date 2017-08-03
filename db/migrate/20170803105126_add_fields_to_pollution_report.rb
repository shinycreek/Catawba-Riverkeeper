class AddFieldsToPollutionReport < ActiveRecord::Migration[5.1]
  def change
  	add_column :pollution_reports, :county, :string
  	add_column :pollution_reports, :address, :string
  	add_column :pollution_reports, :responsible_party, :string
  	add_column :pollution_reports, :other_information, :string
  end
end
