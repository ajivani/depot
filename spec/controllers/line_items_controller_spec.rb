require 'spec_helper'

describe LineItemsController do
render_views
  def mock_line_item(stubs={})
    @mock_line_item ||= mock_model(LineItem, stubs).as_null_object
  end
  describe "POST 'create'" do
    before(:each) do
      @product= Factory(:product)
      @cart = Cart.create!#not needed
      @line_item = @cart.add_product(@product.id)#@line_item = @cart.line_items.create!(:product_id=>@product, :price=>@) #not needed
    end
    it "should have a valid line_item" do
      @product.should_not be_nil
      @cart.should_not be_nil
      @line_item.should_not be_nil      
    end
    describe "success" do
      it "should change the lineItem by 1" do
        lambda do
          post :create, :product_id=>Factory(:product).id, :price =>Factory(:product).price
        end.should change(LineItem, :count).by(1)
      end
      it "should render the show page for the cart item" do
        post :create, :product_id=>Factory(:product).id, :price => Factory(:product).price
        response.should redirect_to(store_path) #the value of @line_item from contoller comes here
      end
    end
  end

end
