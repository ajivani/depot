require 'faker'
namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    Product.create!(:title => "Rails Tutorial.org",
                 :description => "<p>Everything you need!</p> <p> And somethings you don't</p>",
                 :image_url => "/images/debug.jpg",
                 :price => 10.95)
    99.times do |n|
      title  = "Product #{n} #{Faker::Name.name}"
      description = "<p>example-#{n+1}</p><p>2nd line of description #{n}....@railstutorial.org</p>"
      image_url  = "/images/rails.png"
      price = (n+1).to_f 
      Product.create!(:title => title,
                   :description => description,
                   :image_url => image_url,
                   :price => price)
    end
  end
end

