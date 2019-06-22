require 'pry'

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
  coupons.each do |coupon|
    item = coupon[:item]
    if cart.keys.include?(item)
      if coupon[:num] <= cart[item][:count]
        price_w_coupon = coupon[:cost] / coupon[:num]  
        cart["#{item} W/COUPON"] = {:price => price_w_coupon, :clearance => cart[item][:clearance], :count => coupon[:num]}
        cart[item][:count] -= coupon[:num]
      end
      while  coupon[:num] <= cart[item][:count]
        cart["#{item} W/COUPON"][:count] += coupon[:num]
        cart[item][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, info|
    if info[:clearance] == true
      new_price = info[:price] * 0.80
      new_price = new_price.round(2)
      cart[item][:price] = new_price
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  total = 0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cart.each do |item, info|
    total += cart[item][:price] * cart[item][:count]
    total = total.round(2)
  end
  if total > 100
    total = total * 0.90
    total = total.round(2)
  end
  total
end
