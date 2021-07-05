def consolidate_cart(cart)
  # code here
  item_list = []
  consolidated = cart.uniq
  consolidated.each {|hash| hash.values[0][:count] = 0 }
  cart.each { |hash| item_list << hash.keys }
  item_list.flatten.each do |item|
    consolidated.each do |hash|
      if hash.keys[0] == item
        hash.values[0][:count] += 1
      end
    end
  end
    return_hash = {}
    consolidated.each do |hash|
      return_hash[hash.keys.first] = hash.values.first
    end
    return_hash
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    type = coupon[:item]
    if cart[type] && cart[type][:count] >= coupon[:num]
      if cart["#{type} W/COUPON"]
        cart["#{type} W/COUPON"][:count] += 1
      else
        cart["#{type} W/COUPON"] = {count: 1, price: coupon[:cost],clearance: cart[type][:clearance]}
      end
      cart[type][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item,values|
    if values[:clearance] == true 
      values[:price] = values[:price] * 0.80
      values[:price] = values[:price].round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  return_cart = consolidate_cart cart
  return_cart = apply_coupons return_cart,coupons
  return_cart = apply_clearance return_cart
  price = 0.00
  return_cart.each do |items,values|
    item_cost = values[:count]* values[:price] 
    price += item_cost
  end
  price > 100 ? price * 0.90 : price
end
