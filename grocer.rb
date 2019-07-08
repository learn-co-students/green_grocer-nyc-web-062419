require 'pry'
def consolidate_cart(cart)
  # code here
  x = {}
  cart.each do |item|
    if x[item.keys[0]]
      x[item.keys[0]][:count] += 1
    else
      x[item.keys[0]] = {
        price: item.values[0][:price],
        count: 1,
        clearance: item.values[0][:clearance]
      }
    end
  end
  x
end

def apply_coupons(cart=z, coupons=y)
  # code here
  coupons.each do |item|
    if cart.keys.include?(item[:item])
      if cart[item[:item]][:count] >= item[:num]  
        name = "#{item[:item]} W/COUPON"
        if cart[name]
        cart[name][:count] += item[:num]
        else
        cart[name] = {
          price: item[:cost] / item[:num],
          count: item[:num],
          clearance: cart[item[:item]][:clearance]
        }
        end
        cart[item[:item]][:count] -= item[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price] * 0.80).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  
  new_cart = consolidate_cart(cart)
  cart_with_coupons = apply_coupons(new_cart,coupons)
  final_cart = apply_clearance(cart_with_coupons)
  total = 0.0

  final_cart.keys.each do |item|
    total += final_cart[item][:price] * final_cart[item][:count]
  end
  
  total > 100.00 ? (total * 0.90).round : total

end

