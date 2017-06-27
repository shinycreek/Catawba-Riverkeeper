class CreateUserSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :user_settings do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :country
      t.string :address
      t.string :city
      t.string :state, :limit => 2
      t.string :zip
      t.string :phone_id

      t.timestamps
    end
  end
end
