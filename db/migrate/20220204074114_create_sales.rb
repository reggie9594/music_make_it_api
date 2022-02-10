class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.integer :product_id
      t.integer :customer_id
      t.float :price
      t.integer :quantity
      t.text :dilievery_address
      t.string :payment_method

      t.timestamps
    end
  end
end
