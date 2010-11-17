class StoreController < ApplicationController
  def index
    @cart = current_cart
    @products = Product.all
    @page_title = "My List"
    @title = "The List"
    if session[:counter].nil?
      session[:counter] = 0
    else
      session[:counter] +=1
    end
  end
end
