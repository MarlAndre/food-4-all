class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  around_action :switch_time_zone, if: :current_user


  protect_from_forgery with: :exception, prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # adding custom permitting parameters to devise model
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username address])

    devise_parameter_sanitizer.permit(:account_update, keys: %i[username address])
  end

  private

  # Rails apps use UTC as the default timezone.
  # Our 'Users' table has a column "time_zone" which sets EST as default timezone.
  # This method switch the timezone according to the current user's.
  # Users can change their timezone in profile page (to be created) as appropriate.
  def switch_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
