Rails.application.routes.draw do
  root to: redirect(Avo.configuration.root_path)

  devise_for :users

  authenticate :user do
    mount_avo
  end
end

if defined? ::Avo
  Avo::Engine.routes.draw do
    scope :resources do
      get "users/impersonate/:id", to: "users#impersonate", as: :impersonate
      post :stop_impersonating, to: "users#stop_impersonating", as: :stop_impersonating
    end
  end
end