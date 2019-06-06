class AddDateObservedToTrashLoggers < ActiveRecord::Migration[5.1]
  def up
    add_column :trash_loggers, :date_observed, :datetime

    assign_created_at_value_to_date_observed
  end

  def down
    remove_column :trash_loggers, :date_observed
  end

  private

  def assign_created_at_value_to_date_observed
    trash_loggers = TrashLogger.all
    trash_loggers.each do |trash_logger|
      trash_logger.date_observed = trash_logger.created_at
      trash_logger.save
    end
  end
end
