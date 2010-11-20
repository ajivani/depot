module ApplicationHelper
  def title
    base_title = "The Depot"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def hidden_div_if(condition, attributes={}, &block)
    if condition
      attributes['style'] = "display: none"
    end
    content_tag("div", attributes, &block) #it's being called with things like ("div", attributes['style'], :id=>"cart", for the block that you get passed on to it 
  end

end
