class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name, limit: 255, null: false
      t.text :description, null: false
      t.integer :price, null: false
      t.integer :quantity, null: false
      t.string :manufacturer, null: false
      t.integer :category, null: false
      t.boolean :is_featured, default: false
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
