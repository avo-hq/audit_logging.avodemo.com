# This controller has been generated to enable Rails' resource routes.
# More information on https://docs.avohq.io/3.0/controllers.html
class Avo::UsersController < Avo::ResourcesController
  def impersonate
    user = User.find(params[:id])
    impersonate_user(user)
    redirect_back fallback_location: root_path
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_back fallback_location: root_path
  end
end
