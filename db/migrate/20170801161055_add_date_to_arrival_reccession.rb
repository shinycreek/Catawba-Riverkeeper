class AddDateToArrivalReccession < ActiveRecord::Migration[5.1]
  def change
    add_column :flow_arrival_recessions, :date, :date
  end
end
