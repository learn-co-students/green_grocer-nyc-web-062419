require "pry"
def consolidate_cart(cart)
  cart.each_with_object ({}) do |keys, cart_hash|
    #binding.pry
    keys.each do |grocery_item, count_attribute|
      if cart_hash.include? (grocery_item)then count_attribute[:count]+=1
        #binding.pry
      else count_attribute[:count]=1 
         cart_hash[grocery_item]= count_attribute
        #binding.pry
      end
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon_discount|
    item_name= coupon_discount[:item]
    if cart[item_name] && cart[item_name][:count]>=coupon_discount[:num]  
      if cart["#{item_name} W/COUPON"]
        cart["#{item_name} W/COUPON"][:count]+=1
        
      else 
        cart["#{item_name} W/COUPON"] = {:count => 1, :price => coupon_discount[:cost]}
        cart["#{item_name} W/COUPON"] [:clearance]= cart[item_name][:clearance]
      end
      cart[item_name][:count]-= coupon_discount[:num]
      #binding.pry

      end
    end
    cart
  end

  


def apply_clearance(cart)
  cart.each do |item_name, item_attribute|
    if item_attribute[:clearance]== true 
      discounted_price= item_attribute[:price]*0.80
      item_attribute[:price]=discounted_price.round(2)
      
    end
    
  end
  cart
end

    
def checkout(cart, coupons)
  consolidated_cart= consolidate_cart(cart)
  cart_with_coupons= apply_coupons(consolidated_cart, coupons)
  checkout_cart=apply_clearance(cart_with_coupons)
  total_amount=0
  checkout_cart.each do |data, attributes|
    total_amount+=attributes[:price]*attributes[:count]
  end
  if total_amount > 100 then total_amount= total_amount*0.90
  end

    total_amount
    
end

