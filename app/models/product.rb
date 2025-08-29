class Product < ApplicationRecord
  has_one_attached :image
  has_many :courses, dependent: :destroy
  has_many :assessments, dependent: :destroy
  belongs_to :product_creator, class_name: "User"
  has_many :product_prices, dependent: :destroy

  after_create :create_catalog_entry_and_class
  after_commit :sync_with_stripe, on: [ :create, :update ]

  private

  def create_catalog_entry_and_class
    sanitized_name = name.gsub(/[^0-9a-z ]/i, "").strip
    sanitized_name = "Product#{sanitized_name}" if sanitized_name =~ /^\d/
    class_name = "#{sanitized_name.delete(' ')}CatalogProductSubscription"

    parent_class = "CatalogProductSubscription"
    file_path = Rails.root.join("app", "models", "#{class_name.underscore}.rb")

    unless File.exist?(file_path)
      File.open(file_path, "w") do |file|
        file.puts "class #{class_name} < #{parent_class}"
        file.puts "end"
      end
    end
    load file_path
  end

  def sync_with_stripe
    if stripe_product_id.blank?
      product = Stripe::CreateStripeProductService.process!(product: self)
      update_column(:stripe_product_id, product.id)
      stripe_price = Stripe::CreateStripePriceService.process!(cost: cost, product: product)
      product_prices.create!(
        stripe_price_id: stripe_price.id,
        price: stripe_price.unit_amount,
        currency: stripe_price.currency,
        active: true,
        product_id: id
      )
    elsif saved_change_to_cost?
      stripe_price = Stripe::CreateStripePriceService.process!(cost: cost, product: stripe_product_id)
      product_prices.update_all(active: false)
      product_prices.create!(
        stripe_price_id: stripe_price.id,
        price: stripe_price.unit_amount,
        currency: stripe_price.currency,
        active: true,
        product_id: id
      )
    end
  end
end
