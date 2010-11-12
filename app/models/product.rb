class Product < ActiveRecord::Base
  validates :title, :description,  :presence => true
  validates :price, :numericality=>{:greater_than_or_equal_to => 0.01}
  validates :image_url, :format => {:with=> %r{\.(gif|jpg|png)$}i,
                                    :message=> 'must be a URL for a .gif or .jpg or .png'}
end
