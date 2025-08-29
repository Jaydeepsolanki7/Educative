class CreateProductPrices < ActiveRecord::Migration[7.2]
  def change
    create_table :product_prices do |t|
      t.string :stripe_price_id
      t.string :price_name
      t.decimal :price
      t.references :product, null: false, foreign_key: true
      t.boolean :active
      t.string :currency

      t.timestamps
    end
  end
end
