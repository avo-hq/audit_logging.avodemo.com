class Avo::Resources::User < Avo::BaseResource
  self.row_controls = -> {
    action Avo::Actions::Impersonate, label: "Impersonate #{record.name}", style: :primary, color: :blue,
    icon: "heroicons/outline/identification"
    show_button
    edit_button
    delete_button
  }

  def fields
    field :id, as: :id, link_to_record: true
    field :email, as: :text, link_to_record: true
    field :products, as: :has_many
  end

  def filters
    filter Avo::Filters::IsAdmin
  end

  def actions
    action Avo::Actions::Impersonate
  end
end
