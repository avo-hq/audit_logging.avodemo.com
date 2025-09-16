class Avo::Resources::Warehouse < Avo::BaseResource
  def fields
    field :id, as: :id
    field :name, as: :text
    field :inventory_value, as: :money, currencies: %w[USD]
    field :products, as: :has_many
  end
end


