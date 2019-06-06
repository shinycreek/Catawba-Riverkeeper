class AddStatusToTrashLoggers < ActiveRecord::Migration[5.1]
  def up
    default_status = TrashLogger.statuses[:active]
    add_column :trash_loggers, :status, :string, default: default_status

    TrashLogger.update_all(status: default_status)
  end

  def down
    remove_column :trash_loggers, :status
  end
end
