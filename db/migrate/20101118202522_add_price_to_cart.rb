class AddPriceToCart < ActiveRecord::Migration
  def self.up
    add_column :line_items, :price, :decimal, :precision=>8, :scale=>2
    #update the new entry in the LineItems with the value of the price...seems redundant but good practice
    say_with_time "Updating prices ... " do
      LineItem.find(:all).each do |li|
        li.update_attributes(:price =>(li.product.price))
      end
    end
  end

  def self.down
    remove_column :price
  end
end
