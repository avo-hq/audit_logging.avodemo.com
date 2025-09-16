class Avo::Resources::Warehouse < Avo::BaseResource
  def fields
    field :id, as: :id
    field :name, as: :text
    field :inventory_value, as: :number
    field :products, as: :has_many
  end
end


