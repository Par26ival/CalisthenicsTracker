class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
  include AuthorizationHelpers

  def after_sign_out_path_for(resource_or_scope)
    flash[:alert] = "Your session expired due to inactivity."
    reset_session
    root_path
  end

  def authenticate_user!
    return if user_signed_in?
    
    store_location_for(:user, request.fullpath) if request.get?
    redirect_to login_path, alert: "Please sign in to continue."
  end
end
