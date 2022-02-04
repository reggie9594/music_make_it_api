class CreateProductCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :product_categories do |t|
      t.integer :created_by
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
