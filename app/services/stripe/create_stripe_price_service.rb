class Stripe::CreateStripePriceService
  def self.process!(cost:, product:)
    ::Stripe::Price.create(
      unit_amount: (cost.to_f * 100).to_i,
      currency: "usd",
      product: product.is_a?(String) ? product : product.id
    )
  end
end
