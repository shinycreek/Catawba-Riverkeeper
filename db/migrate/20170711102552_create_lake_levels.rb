class CreateLakeLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :lake_levels do |t|
      t.string :lake_name
      t.float :level
      t.float :target

      t.timestamps
    end
  end
end
