class SwapLakeNameForId < ActiveRecord::Migration[5.1]
  def change
    remove_column :lake_levels, :lake_name, :string
    add_column :lake_levels, :lake_id, :integer
  end
end
