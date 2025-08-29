class Stripe::CreateStripeProductService
  def self.process!(product:)
    ::Stripe::Product.create(
      name: product.name,
      description: product.description
    )
  end
end
