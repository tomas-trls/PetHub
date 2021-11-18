class AddBookingConfirmedToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :bookingStatus, :string, :default => "pending"
  end
end
