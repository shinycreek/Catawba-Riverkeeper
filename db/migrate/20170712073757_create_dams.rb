class CreateDams < ActiveRecord::Migration[5.1]
  def change
    create_table :dams do |t|
      t.string :name

      t.timestamps
    end
  end
end
