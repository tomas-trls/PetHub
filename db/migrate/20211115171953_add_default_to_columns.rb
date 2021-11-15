class AddDefaultToColumns < ActiveRecord::Migration[6.0]
  def change
    change_column_default :bookings, :owner_confirmation, false
    change_column_default :bookings, :sitter_confirmation, false
  end
end
