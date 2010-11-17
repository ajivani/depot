class Cart < ActiveRecord::Base
  has_many :line_items, :dependent=>:destroy #each line_item has contains a ref to it's cart's id. ie it has a field called cart_id (te foreign key of that table)
end
