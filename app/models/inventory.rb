class Inventory < ApplicationRecord
  has_paper_trail
  
  has_many :products, after_add: :recalc_total!, after_remove: :recalc_total!

  def recalc_total!(product = nil)
    update!(total_value: products.sum("price * quantity"))
  end
end
