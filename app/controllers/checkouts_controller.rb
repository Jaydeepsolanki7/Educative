# app/controllers/checkouts_controller.rb
class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params[:product_id])
    price   = product.product_prices.last

    session = Stripe::Checkout::Session.create(
      customer_email: current_user.email,
      payment_method_types: [ "card" ],
      mode: "payment",
      line_items: [ {
        price: price.stripe_price_id,
        quantity: 1
      } ],
      success_url: success_checkouts_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: cancel_checkouts_url
    )

    redirect_to session.url, allow_other_host: true
  end

  def success
  end

  def cancel
  end
end
