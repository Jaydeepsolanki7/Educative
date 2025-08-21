class AddProductIdToCatalogProduct < ActiveRecord::Migration[7.2]
  def change
    add_reference :catalog_products, :product, foreign_key: true, null: false
  end
end
