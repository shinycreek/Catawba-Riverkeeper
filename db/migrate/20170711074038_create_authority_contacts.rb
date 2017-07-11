class CreateAuthorityContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :authority_contacts do |t|
      t.text :description
      t.string :display_name
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
