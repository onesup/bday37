class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  force_ssl
  protect_from_forgery with: :exception
  layout :layout_by_resource

  def check_admin
    unless current_user.email == "admin@admin.com"
      redirect_to root_path, notice: '권한이 필요합니다.'
    end
  end
    
  protected

  def layout_by_resource
    if devise_controller?
      "admin"
    else
      "application"
    end
  end
  
end
