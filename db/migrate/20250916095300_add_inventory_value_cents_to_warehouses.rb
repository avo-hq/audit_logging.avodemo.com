class AddInventoryValueCentsToWarehouses < ActiveRecord::Migration[7.2]
  def up
    add_column :warehouses, :inventory_value_cents, :integer, null: false, default: 0
    add_column :warehouses, :inventory_value_currency, :string, null: false, default: 'USD'

    if column_exists?(:warehouses, :inventory_value)
      execute <<~SQL
        UPDATE warehouses SET inventory_value_cents = COALESCE(inventory_value, 0)
      SQL
      remove_column :warehouses, :inventory_value
    end
  end

  def down
    add_column :warehouses, :inventory_value, :integer, null: false, default: 0
    execute <<~SQL
      UPDATE warehouses SET inventory_value = COALESCE(inventory_value_cents, 0)
    SQL
    remove_column :warehouses, :inventory_value_cents
    remove_column :warehouses, :inventory_value_currency
  end
end


