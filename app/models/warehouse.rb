class Warehouse < ApplicationRecord
  has_paper_trail

  has_many :products, after_add: :recalc_total!, after_remove: :recalc_total!

  monetize :inventory_value_cents

  def recalc_total!(product = nil)
    update!(inventory_value_cents: products.sum("price_cents * quantity"))
  end
end


