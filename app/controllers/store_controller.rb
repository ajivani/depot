class StoreController < ApplicationController
  def index
    @products = Product.all
    @page_title = "My List"
    @title = "The List"
  end
end
