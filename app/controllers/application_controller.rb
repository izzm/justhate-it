class ApplicationController < ActionController::Base
  protect_from_forgery
  
protected
  
  def handle_unverified_request
    true
  end
  
  def check_user
    redirect_to authentications_path if current_user.nil?
  end
end
