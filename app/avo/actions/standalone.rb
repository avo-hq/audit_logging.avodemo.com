class Avo::Actions::Standalone < Avo::BaseAction
  self.name = "Standalone"
  self.standalone = true

  def handle(**args)
    info "Standalone action"
    close_modal
  end
end
