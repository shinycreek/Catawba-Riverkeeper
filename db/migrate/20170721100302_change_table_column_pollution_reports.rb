class ChangeTableColumnPollutionReports < ActiveRecord::Migration[5.1]
  def change
  	remove_column :pollution_reports, :adjacent_area, :text
  	remove_column :pollution_reports, :describe_location, :text

  	add_column    :pollution_reports, :pollution_duration, :string
  	add_column    :pollution_reports, :waterway_affected, :string
  	add_column    :pollution_reports, :pollution_observed_at, :datetime
  end
end
