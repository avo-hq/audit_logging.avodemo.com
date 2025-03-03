class Avo::Actions::ChangePrice < Avo::BaseAction
  self.name = "Change Price"

  self.audit_logging = {
    activity: true
  }

  def fields
    field :price, as: :number, default: -> { resource.record.price rescue nil }
  end

  def handle(query:, fields:, current_user:, resource:, **args)
    query.each do |record|
      record.update!(price: fields[:price])
    end
  end
end
