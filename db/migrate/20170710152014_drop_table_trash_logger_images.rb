class DropTableTrashLoggerImages < ActiveRecord::Migration[5.1]
  def change
  	drop_table :trash_logger_images
  end
end
