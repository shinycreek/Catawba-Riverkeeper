ActiveAdmin.register TrashLogger do
  actions :index

  filter :status, as: :select, collection: TrashLogger.statuses
  preserve_default_filters!

  member_action :archive, method: :put do
    status = TrashLogger.statuses[:archived]
    resource.update(status: status)
    redirect_to admin_trash_loggers_path, notice: "Archived!"
  end

  member_action :restore, method: :put do
    status = TrashLogger.statuses[:active]
    resource.update(status: status)
    redirect_to admin_trash_loggers_path, notice: "Restored!"
  end

  index do
    TrashLogger.column_names.each do |c|
      column c.to_sym
    end
    column :actions do |trash_logger|
      if trash_logger.active?
        link_to "archive", archive_admin_trash_logger_path(trash_logger), method: :put
      else
        link_to "restore", restore_admin_trash_logger_path(trash_logger), method: :put
      end
    end
  end
end

