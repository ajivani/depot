require 'spec_helper'

describe LineItem do
  #pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    @book = Factory(:product)
    @cart = Factory(:cart)
    @attr = {:product_id=>@book.id, :cart_id=>@cart.id}
    @li = LineItem.create!(@attr)
  end
  it "should create a new instance with valid attributes" do
    
    li_found = LineItem.find_by_product_id(@book.id)
    li_found.should_not be_nil
    li_found.product_id.should == @attr[:product_id]
    li_found.cart_id.should == @attr[:cart_id]
  end
  it "shouldn't create one without a valid cart" do
    LineItem.new(@attr).should be_valid
    LineItem.new(:product_id=>@book.id, :cart_id=>"not a number").should_not be_valid
  end
  it "shouldn't create a li without a valid product_id" do
    LineItem.new(:product_id=>"not a number", :cart_id=>@cart.id).should_not be_valid
  end
  it "a line item should respond to cart and product methods...ie li.product and li.cart" do
    @li.should respond_to(:product)
    @li.should respond_to(:cart)
    
  end


end
