class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.length == 0
        resp.write "Your cart is empty"
      else 
        @@cart.each { |item| resp.write "#{item}\n"}
      end  # Ends if statement about Cart length
    elsif req.path.match(/add/)
      additem = req.params["item"]
      if @@items.include?(additem)
        @@cart << additem
        resp.write "added #{additem}"
      else
        resp.write "We don't have that item"
      end  # Ends IF statement to add valid item to card 
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end


end
