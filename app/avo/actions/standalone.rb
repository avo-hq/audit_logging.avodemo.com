class Avo::Actions::Standalone < Avo::BaseAction
  self.name = "Standalone"
  self.standalone = true

  self.audit_logging = {
    activity: true
  }

  def handle(**args)
    inform "Standalone action"
    close_modal
  end
end
