class CreateTrashLoggers < ActiveRecord::Migration[5.1]
  def change
    create_table :trash_loggers do |t|
      t.text :describe_trash
      t.text :describe_location
      t.text :adjacent_waterway
      t.string :phone_id
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
