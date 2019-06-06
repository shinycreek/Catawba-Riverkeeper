class AddApiLakeIdToLakes < ActiveRecord::Migration[5.1]
  def change
    add_column :lakes, :api_lake_id, :integer
  end
end
