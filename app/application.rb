class Application

  @@items = ["Apples","Carrots","Pears"]
  # @@items = %w("Apple Carrots Pears")

  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each { |item| resp.write "#{item}\n" }
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match /cart/
      resp.write "Your cart is empty" if @@cart.empty?
      @@cart.each { |item| resp.write "#{item}\n" }
    elsif req.path.match /add/
      need_to_add = req.params["item"]
      if @@items.include? need_to_add
        @@cart << need_to_add
        resp.write "added #{need_to_add}"
      else
        resp.write "We don't have that item"
      end
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
