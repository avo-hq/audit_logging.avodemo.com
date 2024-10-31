class Avo::Resources::AvoActivity < Avo::BaseResource
  self.index_controls = -> {}
  self.visible_on_sidebar = false
  self.record_selector = false
  self.model_class = "Avo::Activity"
  self.authorization_policy = AvoActivityPolicy
  self.row_controls = -> {
    show_button
    delete_button
  }

  def fields
    field :id, as: :id
    field :action, as: :text, sortable: true
    field :preview, as: :preview
    field :activity_class, as: :text, sortable: true, filterable: true
    with_options hide_on: :index do
      field :author_id, as: :number
      field :author_type, as: :text
    end
    author_link_field
    field :payload, as: :code, show_on: :preview, format_using: -> { JSON.pretty_generate(JSON.parse(value)) }
    field :created_at, as: :date_time, sortable: true, filterable: true
    field :avo_activity_pivots, as: :has_many
  end

  def filters
    dynamic_filter :action,
      type: :select,
      options: Avo::AuditLogging::AUDIT_LOGGING_DEFAULTS[:actions].keys
  end

  def author_link_field
    field :author, as: :text, html: true do
      if record.author_type.present? && record.author_id.present?
        resource.link_for_type_and_id type: record.author_type, id: record.author_id
      end
    end
  end

  def link_for_type_and_id(type:, id:)
    # Instatiate the model class
    model_class = type.constantize

    # Search for and instantiate the resource
    resource = Avo.resource_manager.get_resource_by_model_class(model_class).new

    # Find the record
    record_instance = resource.find_record id

    # Hydrate the resource
    resource.hydrate(record: record_instance)

    # Generate the link
    link_to resource.record_title, resource_path(resource: resource, record: record_instance)
  rescue
    nil
  end
end
