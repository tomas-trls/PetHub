class AddPriceToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :price, :float
  end
end
