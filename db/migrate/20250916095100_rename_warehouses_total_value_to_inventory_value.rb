class RenameWarehousesTotalValueToInventoryValue < ActiveRecord::Migration[7.2]
  def change
    rename_column :warehouses, :total_value, :inventory_value
  end
end


