class Avo::Resources::Product < Avo::BaseResource
  self.audit_logging = {
    activity: true
  }

  self.title = :name

  def fields
    main_panel do
      field :id, as: :id, link_to_record: true
      field :name, as: :text, link_to_record: true
      field :manufacturer, as: :text
      field :price, as: :number, step: 1
      field :quantity, as: :number, step: 1
      field :description, as: :trix
      field :is_featured, as: :boolean
      field :category, as: :select, enum: ::Product.categories

      if Avo::AuditLogging.configuration.enabled?
        sidebar do
          tool Avo::ResourceTools::Timeline
        end
      end
    end
  end

  def actions
    action Avo::Actions::ChangePrice
    action Avo::Actions::Standalone
  end
end
