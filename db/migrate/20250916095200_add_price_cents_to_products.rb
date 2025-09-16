class AddPriceCentsToProducts < ActiveRecord::Migration[7.2]
  def up
    add_column :products, :price_cents, :integer, null: false, default: 0
    add_column :products, :price_currency, :string, null: false, default: 'USD'

    if column_exists?(:products, :price)
      execute <<~SQL
        UPDATE products SET price_cents = COALESCE(price, 0)
      SQL
    end
  end

  def down
    remove_column :products, :price_cents
    remove_column :products, :price_currency
  end
end


