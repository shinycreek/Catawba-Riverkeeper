class CreateFlowArrivalRecessions < ActiveRecord::Migration[5.1]
  def change
    create_table :flow_arrival_recessions do |t|
    	t.references :flow_arrival_location
      t.datetime :arrival_time
      t.datetime :recedes_time

      t.timestamps
    end
  end
end
