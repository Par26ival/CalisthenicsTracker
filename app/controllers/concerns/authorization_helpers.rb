module AuthorizationHelpers
  extend ActiveSupport::Concern

  def require_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to access this section."
    end
  end
end
