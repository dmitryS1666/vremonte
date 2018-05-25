class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    format.js   { head :forbidden }
    format.json { head :forbidden }
    format.html { redirect_to root_path, notice: exception.message }
  end


  protected
  def configure_permitted_parameters
    added_attrs = [:avservice, :description, :additional_fields]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
  end

end
