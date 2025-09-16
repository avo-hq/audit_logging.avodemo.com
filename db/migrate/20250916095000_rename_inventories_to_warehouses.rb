class RenameInventoriesToWarehouses < ActiveRecord::Migration[7.2]
  def change
    # Update foreign keys and references from inventories to warehouses
    remove_foreign_key :products, :inventories

    rename_table :inventories, :warehouses

    rename_column :products, :inventory_id, :warehouse_id

    # Rename index on products for the foreign key
    if index_name_exists?(:products, "index_products_on_inventory_id")
      rename_index :products, "index_products_on_inventory_id", "index_products_on_warehouse_id"
    end

    add_foreign_key :products, :warehouses
  end
end

