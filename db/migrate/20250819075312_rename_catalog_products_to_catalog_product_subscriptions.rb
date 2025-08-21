class RenameCatalogProductsToCatalogProductSubscriptions < ActiveRecord::Migration[7.2]
  def change
    rename_table :catalog_products, :catalog_product_subscriptions
    add_reference :catalog_product_subscriptions, :user, null: false, foreign_key: true
  end
end