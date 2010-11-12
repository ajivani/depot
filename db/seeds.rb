#---
# Excerpted from "Agile Web Development with Rails, 4rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
# encoding: utf-8
Product.delete_all
Product.create(:title=> "RailsTutorial.org", 
               :description=> %{<p>
                 <em>RubyonRails Tutorial.org</em> will show you how to do things the Rails Way, also once you've made a twitter like app, 
                 you'll understand a lot more than just the basic shit.
                 </p>
                 <p>
                  It's the best tutorial out there. You'll have to view it.
                 </p>},
                 :image_url=> '/images/rails.png',
                 :price=>0.01)
Product.create(:title => 'Web Design for Developers',
  :description => 
    %{<p>
       <em>Web Design for Developers</em> will show you how to make your
       web-based application look professionally designed. We'll help you
       learn how to pick the right colors and fonts, avoid costly interface
       and accessibility mistakes -- your application will really come alive.
       We'll also walk you through some common Photoshop and CSS techniques
       and work through a web site redesign, taking a new design from concept
       all the way to implementation.
      </p>},
  :image_url =>   '/images/wd4d.jpg',    
  :price => 42.95)

Product.create(:title => 'Programming Ruby 1.9',
  :description =>
      %{<p>
        Ruby is the fastest growing and most exciting dynamic language out
        there. If you need to get working programs delivered fast, you should
        add Ruby to your toolbox.
      </p>},
  :image_url => '/images/ruby.jpg',
  :price => 49.50)
  # . . .

Product.create(:title => 'Debug It!',
  :description => 
    %{<p>
        Professional programmers develop a knack of unerringly zeroing in on
        the root cause of a bug. They can do that because they've written a
        lot of buggy code and then gained experience fixing it. This book
        captures all this experience -- use it, and you'll find you write fewer
        bugs, and the ones you do write will become easier to hunt down.
      </p>},
  :image_url => '/images/debug.jpg',
  :price => 34.95)
