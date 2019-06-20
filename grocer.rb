def consolidate_cart(cart)
  # code here
  tally = {}
  cart.each do |item|
    if tally.keys.include? item.keys[0]   
      tally[item.keys[0]][:count] += 1
    else
      tally[item.keys[0]] = {:price => item[item.keys[0]][:price], :clearance => item[item.keys[0]][:clearance], :count => 1}
    end
  end
  tally
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if coupon[:num] <= cart[coupon[:item]][:count]
        used = cart[coupon[:item]][:count] / coupon[:num]
        clear = cart[coupon[:item]][:clearance]
        cart[coupon[:item]][:count] -= coupon[:num] * used
        cart[coupon[:item] + " W/COUPON"] = {price: coupon[:cost], clearance: clear, count: used}
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, info|
    if info[:clearance]
      info[:price] = (info[:price] * 0.8).round(2)
    end 
  end
  cart
end

def checkout(cart, coupons)
  # code here

  cart = consolidate_cart(cart)

  cart = apply_coupons(cart, coupons)

  cart = apply_clearance(cart)

  total = 0.0

  cart.each do |item, info|
    total += info[:price] * info[:count].to_f
  end

  if total > 100.0
    total *= 0.9
  end

  total.round(2)

end
