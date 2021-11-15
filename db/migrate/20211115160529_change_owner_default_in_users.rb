class ChangeOwnerDefaultInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :owner, false
  end
end
