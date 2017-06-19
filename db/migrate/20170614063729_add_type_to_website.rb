class AddTypeToWebsite < ActiveRecord::Migration[5.1]
  def change
    add_column :websites, :website_type, :string
  end
end
