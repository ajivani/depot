require 'spec_helper'

describe Product do
  
  #pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    @book = Factory(:product)
    @attr = { :title=>"A confederacy of dunces", 
              :description=>"<p> a very awesoem book</p> <p>One of my favourites</p>",
              :image_url=>'picture.jpg',
              :price=>10.00 }              

  end
  it 'should create a new instance given valid attributes' do
    dunces_book = Product.create!(@attr)
    book_found = Product.find_by_title(@attr[:title])
    book_found.should_not be_nil
    book_found.title.should == @attr[:title]
  end
  it '@book should be valid for tests to work' do
    book_found = Product.find_by_title(@book.title)
    book_found.should_not be_nil
    book_found.should == @book 
  end
  describe "validations" do
    it "should require a title" do
      @no_title_product = Product.new(@attr.merge(:title=>""))
      @no_title_product.should_not be_valid
    end
    it "should have a title does the same thing as above validation" do  
      @book.title = ""
      @book.save.should be_false
    end
    it 'should have a non-blank or very large description' do
     str = ""
     9000.times { str << "a" }
     long_description = Product.new(@attr.merge(:description=>str))
     long_description.should be_valid
     no_description = Product.new(@attr.merge(:description=>""))
     no_description.should_not be_valid
     @book.id.should_not be_nil
     #@book.should_not == long_description
     #@book.description = ""
     #@book.save.should be_false
    end
    it "should have a non-blank image url" do
      blank_image = Product.new(@attr.merge(:image_url=>""))
      blank_image.should_not be_valid
    end
    it 'no saving in weird file formats (only png jpg and gif work)' do
      invalid_types = ["file.JP.G", "something.pngs", "png.b", "jpg", "file.jp.g"]
      the_file = Factory(:product)
      invalid_types.each do |filename|
        the_file = Product.new(@attr.merge(:image_url=>filename))
        the_file.should_not be_valid
      end
    end
    it 'should save in the .jpg .png or .gif images' do
      valid_types = ["file.jpg", ".JPG", ".Jpg", ".jPg", ".png", ".gjlaskdf.jgp.jgpjpg.gif", "https://some/lsom.gpg.png"]
      the_file = Factory(:product)
      valid_types.each do |filename|
        the_file = Product.new(@attr.merge(:image_url=>filename))
        the_file.should be_valid
      end
    end
    it "should not save a price less than 0.01" do
      @book.should be_valid
      @book.price = 0.00
      @book.should_not be_valid
      @book.price = 0.01
      @book.should be_valid
      @book.price = -0.01
      @book.should_not be_valid
      @book.price = 0
      @book.should_not be_valid
      @book.price = 100
      @book.should be_valid
      @book.price = 0.01999
      @book.should be_valid
    end
    it "shouldn't accept 0.005 and round it?" do
      @book.price = 0.0051
      @book.should_not be_valid
    end
  end


end
