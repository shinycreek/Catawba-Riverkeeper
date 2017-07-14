class CreateFlowArrivalLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :flow_arrival_locations do |t|
      t.references :dam
      t.string :name

      t.timestamps
    end
  end
end
