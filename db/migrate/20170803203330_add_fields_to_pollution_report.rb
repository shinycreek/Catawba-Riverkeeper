class AddFieldsToPollutionReport < ActiveRecord::Migration[5.1]
  def change
    add_column :pollution_reports, :other_info, :string
    add_column :pollution_reports, :pollution_address, :string
    add_column :pollution_reports, :responsible_party, :string
  end
end
