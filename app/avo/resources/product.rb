class Avo::Resources::Product < Avo::BaseResource
  def fields
    field :id, as: :id, link_to_record: true
    field :name, as: :text, link_to_record: true
    field :manufacturer, as: :text
    field :price, as: :number, step: 1
    field :quantity, as: :number, step: 1
    field :description, as: :trix
    field :is_featured, as: :boolean
    field :category, as: :select, enum: ::Product.categories
  end

  def actions
    action Avo::Actions::ChangePrice
    action Avo::Actions::Standalone
  end
end
