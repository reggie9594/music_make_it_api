class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.integer :name
      t.text :description
      t.integer :created_by
      t.integer :quantity
      t.integer :category_id
      t.float :price

      t.timestamps
    end
  end
end
