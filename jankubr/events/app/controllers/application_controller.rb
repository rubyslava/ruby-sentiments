class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :check_rights

protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def check_rights
    raise PermissionDenied
  end

  rescue_from 'PermissionDenied' do |exception|
    render file: 'public/403', format: [:html], status: 403, layout: false
  end
end

class PermissionDenied < StandardError
end

