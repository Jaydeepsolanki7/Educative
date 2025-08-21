class ExploreController < ApplicationController
  def index
    @products = Product.all
  end
end
