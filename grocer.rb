def consolidate_cart(cart)
  # code here
  consolidated_cart = {}
  
  cart.each do |item_hash|
    item_hash.each do |item, info_hash|
      if consolidated_cart[item]
        consolidated_cart[item][:count] += 1
      else
        consolidated_cart[item] = info_hash
        consolidated_cart[item][:count] = 1
      end
    end
  end
  
  consolidated_cart
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
