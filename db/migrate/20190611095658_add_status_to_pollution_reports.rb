class AddStatusToPollutionReports < ActiveRecord::Migration[5.1]
  def up
    default_status = PollutionReport.statuses[:active]
    add_column :pollution_reports, :status, :string, default: default_status

    PollutionReport.update_all(status: default_status)
  end

  def down
    remove_column :pollution_reports, :status
  end
end
