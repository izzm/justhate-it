class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    #render :json => omniauth.to_json 
    #return
    
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      authentication.upadte_tokens!(omniauth)
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.add_authentication(omniauth)
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      user = User.new
      user.add_authentication(omniauth)
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end

  def destroy
    if current_user.authentications.count > 1
      @authentication = current_user.authentications.find(params[:id])
      @authentication.destroy
      flash[:notice] = "Successfully destroyed authentication."
    else
      flash[:notice] = "Can not remove last authentication"
    end
    redirect_to authentications_url
  end
end
