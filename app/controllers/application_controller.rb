class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include Pundit::Authorization
  allow_browser versions: :modern

  def after_sign_up_path_for(resource)
    new_profile_path
  end
  
  def after_sign_up_path_for(resource)
    edit_profile_path # or wherever your role-selection/profile form is
  end
  
end
