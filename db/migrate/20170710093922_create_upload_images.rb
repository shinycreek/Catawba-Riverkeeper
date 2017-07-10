class CreateUploadImages < ActiveRecord::Migration[5.1]
  def change
    create_table :upload_images do |t|
      t.string :image
      t.integer :imageable_id
      t.string :imageable_type

      t.timestamps
    end
  end
end
