class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: -> {params[:controller].split('/')[0] == 'devise_token_auth'}
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :bio])
  end
end
