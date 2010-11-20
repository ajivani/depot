require 'spec_helper'

describe CartsController do
render_views
  def mock_cart(stubs={})
    @mock_cart ||= mock_model(Cart, stubs).as_null_object
  end
  before(:each) do
    @book = Factory(:product)
    @cart = Factory(:cart)
  end

  describe "GET index" do
    it "should show the index page for the carts" do
      get :index
      response.should have_selector("h1", :content=>"Listing carts")
    end
  end

  
  describe "POST create" do


  end

  describe "PUT update" do

  end

  describe "DELETE destroy" do
    before(:each) do
      @book = Factory(:product)
      @cart = Factory(:cart)
      @li = @cart.line_items.first #probably not needed
    end
    it "should destroy the cart" do
      lambda do 
        delete :destroy, :id=>@cart.id 
      end.should change(Cart, :count).by(-1)
    end
    it "should redirect to the home page/root page/store_url" do
      delete :destroy, :id=>@cart.id
      response.should redirect_to(store_url)
    end
    it "first we add a li then we destroy the cart for that line item...and so the carts lines in the line_items table should be removed" do
      lambda do
        #@cart.line_items.create!(:product_id=>@book.id)
        @cart.add_product(@book.id)
      end.should change(LineItem, :count).by(1)
      lambda do
        delete :destroy, :id=>@cart.id
      end.should change(LineItem, :count).by(-1)
    end
    
    it "shoulc change the LineItem count as well" do
      lambda do
        #@cart.line_items.create!(:product_id=>@book.id)
        @cart.add_product(@book.id)
        @li_count = LineItem.count
        delete :destroy, :id=>@cart.id
        @li_count_after_destroy = LineItem.count
        @li_count.should_not == @li_count_after_destroy
        (@li_count-1).should == @li_count_after_destroy
      end.should change(Cart, :count).by(-1)
    end

  end

  describe "add_product method" do
    before(:each) do
      @book = Factory(:product)
      @cart = Factory(:cart)
      @li = @cart.line_items.first #probably not needed
    end
    it "shoudld add a product correctly" do
      lambda do
        li =  @cart.add_product(@book.id)
        li.save
      end.should change(LineItem, :count).by(1)
      lambda do
        li = @cart.add_product(@book.id)
        li.save
        li = LineItem.where(:product_id=>@book.id).first
        li.quantity.should == 2
      end.should_not change(LineItem, :count)
      lambda do
        new_product = Factory(:product)
        new_product.save
        li = @cart.add_product(new_product.id)
        li.save
        li = LineItem.where(:product_id=>new_product.id).first
        li.quantity.should == 1
      end.should change(LineItem, :count).by(1)
      lambda do
        li = @cart.add_product(@book.id)
        li.save
        li = LineItem.where(:product_id=>@book.id).first
        li.quantity.should == 3
      end.should_not change(LineItem, :count)
    end

  end

end
