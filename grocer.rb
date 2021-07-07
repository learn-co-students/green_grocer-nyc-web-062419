require 'pry'

def consolidate_cart(cart)
  # Initialize empty hash to store new consolidsted hash
  new_hash = {}

  #iterate into cart hash with each method
  cart.each do |item|

  #iterate down into next level of cart hash
      item.each do |food, attribute|

  #assignment operator that states if new hash includes food(true) move to next line of code, if new hash includes food(false) set the statement on left equal to statement on right.
        new_hash[food] ||= attribute

  #if statement on left is true go to next line, if not set the count to zero       
        new_hash[food][:count] ||= 0

  #if the count exist we increment by 1
        new_hash[food][:count] += 1
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  hash = {}
  cart.each do |key, val|
    coupons.each do |coupon|
#if key is coupon'd item and val count is >= number of items required by coupon reduce val count by number of items used by coupon.
      if key == coupon[:item] && val[:count] >= coupon[:num]
        val[:count] -= coupon[:num]
#if hash include coupon increment
        if hash["#{key} W/COUPON"]
          hash["#{key} W/COUPON"][:count] += 2
#otherwise create this coupon hash         
        else
          hash["#{key} W/COUPON"] = {
            :price => (coupon[:cost] / coupon[:num]), 
            :clearance => val[:clearance], 
            :count => coupon[:num]}
            
          end
        end
      end
      hash[key] = val
    end
  hash
end

def apply_clearance(cart)
  cart.each do |key, val|
    if val[:clearance] == true
      val[:price] = (val[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(new_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  final_cart = 0

  clearance_cart.each do |item, attribute|
    final_cart += attribute[:price] * attribute[:count]
end
final_cart > 100 ? final_cart * 0.9 : final_cart
end