class CombineItemsInCart < ActiveRecord::Migration
  def self.up
    #replace multipe items for a single product in a cart with a single item
    Cart.all.each do |cart|
      #count the number of each product in the cart 
      sums = cart.line_items.group(:product_id).sum(:quantity)  #returns a hash like sums = {2=>1, 3=>1, 4=>3, 16=>1} returns product_id and quantity summed up
      sums.each do |product_id, quantity|
        if quantity > 1
          #remove individual items
          cart.line_items.where(:product_id=>product_id).delete_all
          #replace with singe item
          cart.line_items.create(:product_id=>product_id, :quantity=>quantity)
        end
      end
    end
  end

  def self.down
    #split items with quantity greater than one into multiple items
      LineItem.where("quantity>1").each do |li|
        li.quantity.times do
          LineItem.create(:cart_id=>li.cart_id, :product_id=>li.product.id, :quantity=>1) #make 4 line items each with quantity 1
        end
        li.destroy #remove the original line item where quantity = 4 or something. 
      end
  end
end
