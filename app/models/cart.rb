class Cart < ActiveRecord::Base
  has_many :line_items, :dependent=>:destroy #each line_item has contains a ref to it's cart's id. ie it has a field called cart_id (te foreign key of that table)
  
  def total_price
    self.line_items.each.sum {|li| li.total_price}
  end

  def add_product(product_id)
    current_item = self.line_items.where(:product_id=>product_id).first #cart.line_items, self is a cart in most case..the .first since it returns an array array.fist returns the first element of the array
    if current_item
      current_item.quantity += 1
    else 
      current_item = LineItem.new(:product_id=>product_id, :price=>( (Product.find(product_id)).price )) #this can't work since we want to save it later and redirect accordingly current_item = LineItem.create!(:product_id=>product_id)
      self.line_items << current_item
    end
    current_item
  end

end









##
#alternate method for the total price does the same thing
#  def total_price
#    sum = 0
 #   self.line_items.each do |li|
  #    sum += li.quantity * li.product.price
   # end
    #return sum    
  #end
#
#
##
