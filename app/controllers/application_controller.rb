class ApplicationController < ActionController::Base
  before_action :authenticate_user!


  protect_from_forgery with: :exception, prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # adding custom permitting parameters to devise model
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username address])

    devise_parameter_sanitizer.permit(:account_update, keys: %i[username address])
  end
end
