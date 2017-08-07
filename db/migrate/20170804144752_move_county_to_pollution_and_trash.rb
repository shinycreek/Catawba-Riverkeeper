class MoveCountyToPollutionAndTrash < ActiveRecord::Migration[5.1]
  def change
    add_column :pollution_reports, :county, :string
    add_column :trash_loggers, :county, :string
    remove_column :user_settings, :country, :string
  end
end
