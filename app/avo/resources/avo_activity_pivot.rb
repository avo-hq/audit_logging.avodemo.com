class Avo::Resources::AvoActivityPivot < Avo::Resources::AvoActivity
  self.model_class = "Avo::ActivityPivot"

  def fields
    field :record, as: :text, html: true do
      if record.record_type.present? && record.record_id.present?
        resource.link_for_type_and_id type: record.record_type, id: record.record_id
      end
    end
    field :record_type, as: :text
    field :record_id, as: :number
    if defined?(PaperTrail) || defined?(Audited)
      field :activity_pivot, as: :text, html: true do
        if record.activity_pivot_type.present? && record.activity_pivot_id.present?
          resource.link_for_type_and_id type: record.activity_pivot_type, id: record.activity_pivot_id
        end
      end
      field :activity_pivot_type, as: :text
      field :activity_pivot_id, as: :number
    end
  end
end
