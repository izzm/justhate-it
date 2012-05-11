class ApplicationController < ActionController::Base
  protect_from_forgery
  
protected
  
  def handle_unverified_request
    true
  end
end
