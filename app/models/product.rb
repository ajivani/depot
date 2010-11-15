class Product < ActiveRecord::Base
  default_scope :order=> 'title' #Default scopes apply to all queries that start with this model.
  validates :title, :description,  :presence => true
  validates :price, :numericality=>{:greater_than_or_equal_to => 0.01}
  validates :image_url, :format => {:with=> %r{\.(gif|jpg|png)$}i,
                                    :message=> 'must be a URL for a .gif or .jpg or .png'}
end
