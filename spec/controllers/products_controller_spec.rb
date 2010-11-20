require 'spec_helper'

describe ProductsController do
  render_views
  before(:each) do
    @book = Factory(:product)
  end
  
  describe "POST 'create'"do
    describe 'failure' do
      before(:each) do 
        @attr = {:title=>"", :description=>"", :image_url=>"", :price=>""}
      end
      it 'should not create a product' do
        lambda do
          post :create, :product=>@attr
       end.should_not change(Product, :count)
      end
      it 'should render the right page' do
        lambda do
          post :create, :product=>@attr
        end.should render_template() #response.should be_success#this doesn't do what we want it to do since we don't want the result of the block we want the direct result...right after the post request
      end
    end
    describe 'success' do
      before(:each) do 
        @book = Factory(:product)
        @attr = {:title=>"barney's version", :description=>"<p>top ten books</p><p><b>Must read</b></p>",:image_url=>"http://image.something./klsome.lakdj.jpg",:price=>12.95}
      end
      it 'should create a product' do
        lambda do
          post :create, :product=>@attr
        end.should change(Product, :count).by(1)
      end
      it "should render the right show page after it's been created " do
        lambda do 
          post :create, :product=>@attr
        end.should render_template(:action=>:show, :controller=>:products)
        #.should redirect_to(product_path(assigns(:product).id))        
          #redirect_to(:action=>'new', :controller=>'products')#product_path(assigns(:product)))
      end
      it "should render the show page directly after successful creation" do
       # post :create #:action=>"create", :controller=>"products", :product=>@book
        #response.should redirect_to(product_path(@book))
        #response.should redirect_to(product_path(assigns(:product)))
      end
    end
  end#post create
  describe "GET edit" do
    before(:each) do
      @book = Factory(:product)
    end
    it 'should be successful' do
      #get :edit, :id=>@book
      #response.should be_success
    end 
  end#post GET edit
  describe "PUT 'update'"do 
    before(:each) do
      @book = Factory(:product)
    end
    describe "failure" do
      before(:each) do
        @attr = {:title=>"", :description=>"", :image_url=>"", :price=>0.0}
      end
      it "should render the edit page" do
        #put :update, :id=>@book, :product=>@attr
        #response.should render_template('edit')
      end
    end
    describe "success" do
      before(:each) do
        @attr = {:title=>"barney's version", :description=>"<p>top ten books</p><p><b>Must read</b></p>",:image_url=>"http://image.something./klsome.lakdj.jpg",:price=>12.95}
      end
      it 'should save the right book' do
        lambda do
          put :update, :id=>@book, :proudct=>@attr
        end.should_not change(Product, :count) 
      end
      it "should change the user's attributes" do
        put :update, :id=>@book, :product=>@attr
        product = assigns(:product)
        @book.reload
        @book.title.should == product.title
        @book.description.should == product.description
        @book.image_url.should == product.image_url
        @book.price.should == product.price
      end
      it "should re-direct to the product's show page" do
        put :update, :id=>@book, :product=>@attr
        response.should redirect_to(product_path(@book))
      end
    end
  end#PUT update
  describe "DELETE 'destroy'" do
    before(:each) do
      @book = Factory(:product)
    end
    describe "success" do
      it 'should delete the specified product' do
        lambda do
          delete :destroy, :id=>@book
        end.should change(Product, :count).by(-1)
      end
      it "should redirect to the users page" do
        delete :destroy, :id=>@book
        response.should redirect_to(products_path)
      end
    end
  end#DELETE destroy
end 
