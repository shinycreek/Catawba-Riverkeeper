class AddRecordedDateToLakeLevels < ActiveRecord::Migration[5.1]
  def change
    add_column :lake_levels, :date_recorded, :date
  end
end
