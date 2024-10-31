# frozen_string_literal: true

class Avo::Resources::PaperTrail < Avo::BaseResource
  # TODO: translate name
  # TODO: fix whodunnit on actions
  self.visible_on_sidebar = false
  self.model_class = ::PaperTrail::Version

  self.index_controls = -> {}
  self.row_controls = -> {
    action Avo::Actions::Undo, title: "Undo this update", icon: "heroicons/outline/arrow-uturn-left", style: :icon
    show_button
    delete_button
  }

  def fields
    field :id, as: :id
    field :event, as: :text
    field :preview, as: :preview
    field :changes, as: :text do
      record.changeset&.keys&.split(",")&.join(" | ")
    end
    field :whodunnit,
      as: :text,
      readonly: true do
      if record.whodunnit.present?
        user = User.find_by(id: record.whodunnit)
        if user.present?
          link_to user.name, Avo::Engine.routes.url_helpers.resources_user_path(id: user.id)
        else
          record.whodunnit
        end
      end
    end
    field :created_at, as: :date_time
    field :changeset, as: :diff, show_on: :preview
  end

  def actions
    action Avo::Actions::Undo
  end
end
