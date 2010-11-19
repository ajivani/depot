class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  validates :product_id,  :presence=>true,  :numericality=>true
  validates :cart_id,     :presence=>true,  :numericality=>true
  validates :price,       :presence=>true,  :numericality=>{:greater_than_or_equal_to => 0.01}
 
  def total_price 
    self.quantity * self.price
  end
end
