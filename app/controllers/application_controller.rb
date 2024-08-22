class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: t('messages.unauthorized')
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:company_id])
  end
end
