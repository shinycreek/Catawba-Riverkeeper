ActiveAdmin.register TrashLogger do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
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
    column :describe_trash
    column :describe_location
    column :adjacent_waterway
    column :phone_id
    column :latitude
    column :longitude
    column :date_observed
    column :created_at
    column :updated_at
    column :county
    column :status
    column :actions do |trash_logger|
      if trash_logger.active?
        link_to "archive", archive_admin_trash_logger_path(trash_logger), method: :put
      else
        link_to "restore", restore_admin_trash_logger_path(trash_logger), method: :put
      end
    end
  end

  actions :index
end

