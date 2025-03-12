class Avo::Actions::AssignProduct < Avo::BaseAction
  self.name = "Assign Product"
  # self.visible = -> do
  #   true
  # end

  self.audit_logging = {
    activity: true
  }

  def fields
    field :user, as: :select, options: User.all.map { |user| [ user.name, user.id ] }
  end

  def handle(query:, fields:, current_user:, resource:, **args)
    query.each do |record|
      record.assign_to User.find(fields[:user])
    end
  end
end
