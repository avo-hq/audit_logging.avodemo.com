class CreateInventories < ActiveRecord::Migration[7.2]
  def change
    create_table :inventories do |t|
      t.string :name
      t.integer :total_value

      t.timestamps
    end
  end
end
