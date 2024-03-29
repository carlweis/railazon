class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  skip_before_action :authorize

  def index
    @products = Product.order(:title).page params[:page]
  end
end
