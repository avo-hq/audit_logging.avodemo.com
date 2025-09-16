class AddInventoryToProducts < ActiveRecord::Migration[7.2]
  def change
    add_reference :products, :inventory, foreign_key: true
  end
end
