class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    format.js   { head :forbidden }
    format.json { head :forbidden }
    format.html { redirect_to root_path, notice: exception.message }
  end
end
