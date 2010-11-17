class ApplicationController < ActionController::Base
  protect_from_forgery

  private
   def current_cart
     Cart.find(session[:cart_id]) #returns the cart object, session just stores which cart i need to pick up
   rescue ActiveRecord::RecordNotFound
     cart = Cart.create
     session[:cart_id] = cart.id
     cart #returns the cart object
   end

end
