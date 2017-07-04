class CreateTrashLoggerImages < ActiveRecord::Migration[5.1]
  def change
    create_table :trash_logger_images do |t|
      t.references :trash_logger, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
