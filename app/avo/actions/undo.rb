class Avo::Actions::Undo < Avo::BaseAction
  self.name = "Undo change"

  def handle(query:, **args)
    query.first.reify.save!
  end
end
