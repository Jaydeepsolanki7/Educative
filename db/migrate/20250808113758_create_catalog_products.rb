class CreateCatalogProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :catalog_products do |t|
      t.string :type
      t.text :description
      t.string :slug
      t.float :cost
      t.string :catagory
      t.string :stripe_id

      t.timestamps
    end
  end
end
