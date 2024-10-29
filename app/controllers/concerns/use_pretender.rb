module UsePretender
  extend ActiveSupport::Concern

  included do
    impersonates :user
  end
end
