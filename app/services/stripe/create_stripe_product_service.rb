class Stripe::CreateStripeProductService
  def self.process!(product:)
    image_url = Rails.application.routes.url_helpers.url_for(product.image) if product.image.attached?
    ::Stripe::Product.create(
      name: product.name,
      description: product.description,
      images: image_url.present? ? [ image_url ] : []
    )
  end
end
