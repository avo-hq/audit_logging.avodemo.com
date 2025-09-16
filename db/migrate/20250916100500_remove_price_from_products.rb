class RemovePriceFromProducts < ActiveRecord::Migration[7.2]
  def up
    if column_exists?(:products, :price)
      remove_column :products, :price
    end
  end

  def down
    add_column :products, :price, :integer, null: false, default: 0 unless column_exists?(:products, :price)
    execute <<~SQL
      UPDATE products SET price = COALESCE(price_cents, 0)
    SQL
  end
end


