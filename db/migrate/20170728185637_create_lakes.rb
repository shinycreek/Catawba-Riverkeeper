class CreateLakes < ActiveRecord::Migration[5.1]
  def change
    create_table :lakes do |t|
      t.string :name

      t.timestamps
    end
  end
end
