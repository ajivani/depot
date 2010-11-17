#by using the symbol ':user' we get Facgory Girl to simulate the User model
Factory.define :product do |product|
  product.title       "Rails Book"
  product.description %r{<p> this is really cool </p><p>second paragraph</p>}
  product.image_url   "picture.png"
  product.price       10.99
end
Factory.define :cart do |cart|
#no fields just want to use cart.id, since it's the only field that matters
end

Factory.sequence :title do |n|
  "product_#{n}"
end

Factory.define :micropost do |mpost|
  mpost.content  "today i saw a bird it was awesome, i'm gonna tweet this information"
  mpost.association :user
end

