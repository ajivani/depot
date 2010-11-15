require 'spec_helper'

describe StoreController do
  #nothing works without this line
  render_views
  before(:each) do
    @base_title = "The Depot | "
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
    #these tests are failing and i don't know why, tried to select using div.name #name div#name .name nothing works
    #tried the selector tags and none work
    it "should show the home page title" do
        get :index
        response.should have_selector("title", :content=>"The List")
        #response.should_not have_selector("banner", "Home")
    end
    it "should show the side column" do
      get :index
      response.should have_selector("div.side")
    end
    :a
    it "should have the right links on the side panel" do
      get :index
      response.should have_selector("a", :href=>"/", :content=>"Home")
      response.should have_selector("a", :href=>"/products", :content=>"Products")
      response.should have_selector("#columns")
    end
    #it "should have an entry price line and price divs" do
     # get :index
     # response.should have_selector("div.price") #select a div with #nameDiv select div class with #div.nameDiv 
     # response.should have_selector("div.price_line")
     # response.should have_selector("div.entry")
   # end

  end

end
