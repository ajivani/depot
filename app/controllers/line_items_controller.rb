class LineItemsController < ApplicationController
  # GET /line_items
  # GET /line_items.xml
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.xml
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.xml
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  #line_items_path(id) 
  # POST /line_items
  # POST /line_items.xml
  #http://localhost:3000/line_items?product_id=4
  #create takes a product_id as an input! pretty cool
  def create
    session[:counter] = 0 
    @cart = current_cart #applicaiton controller
    product = Product.find(params[:product_id]) #comes fromt he view ie when you hit the button it goes: http://localhost:3000/line_items?product_id=4 
    @line_item = @cart.add_product(product.id)#now we don't need that line since we have a better way of adding elements to the line_items table, one that takes quantity into account @line_item = @cart.line_items.build(:product=>product)#want cart.line_items.build(:product@line_item = @cart.line_items.build(:product_id=>product.id) #@line_item = LineItem.new(params[:line_item])#this is used when we have a page on a form with line_items and shit
   
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to(store_url)} # :notice => 'Line item was successfully created.') } #redirects to @line_item
        format.js {@current_item = @line_item } #pass the current li down to the template...need the right <tr>          #if teh browser asks for a ajax well don't just send them the page over and over, send them this template...ie rails looks for the create template to render.
        format.xml  { render :xml => @line_item, :status => :created, :location => @line_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.xml
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to(@line_item, :notice => 'Line item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.xml
  # check out the path /line_items/(li.id) wiht the delete method for http probably using javascript
  def destroy
    @cart = current_cart
    @line_item = LineItem.find(params[:id])
      @line_item.destroy
      @cart.destroy if @cart.line_items.count < 1
      respond_to do |format|
        format.html { redirect_to(cart_path(session[:cart_id])) }
        format.js 
        format.xml  { head :ok }
      end
  end
end
