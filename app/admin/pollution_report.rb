ActiveAdmin.register PollutionReport do
  actions :index

  filter :status, as: :select, collection: PollutionReport.statuses
  preserve_default_filters!

  member_action :archive, method: :put do
    status = PollutionReport.statuses[:archived]
    resource.update(status: status)
    redirect_to admin_pollution_reports_path, notice: "Archived!"
  end

  member_action :restore, method: :put do
    status = PollutionReport.statuses[:active]
    resource.update(status: status)
    redirect_to admin_pollution_reports_path, notice: "Restored!"
  end

  index do
    PollutionReport.column_names.each do |c|
      column c.to_sym
    end
    column :actions do |pollution_report|
      if pollution_report.active?
        link_to "archive", archive_admin_pollution_report_path(pollution_report), method: :put
      else
        link_to "restore", restore_admin_pollution_report_path(pollution_report), method: :put
      end
    end
  end
end
