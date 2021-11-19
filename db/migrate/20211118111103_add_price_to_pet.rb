class AddPriceToPet < ActiveRecord::Migration[6.0]
  def change
    add_column :pets, :price, :float
  end
end
