class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource_or_scope)
    if current_user.has_pending_invitation? || !current_user.is_confirmed_member?
      user_path(current_user)
    else
      if current_user.manager?
        user_path(current_user)
      else
        organization_path(current_user.organization)
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :role
    devise_parameter_sanitizer.for(:accept_invitation) << :name
    devise_parameter_sanitizer.for(:accept_invitation) << :invited_organization_id
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referer || root_path)
  end
end
