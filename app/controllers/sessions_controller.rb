class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    if auth["provider"] == "facebook"
      user = User.find_by_facebook_id(auth["uid"]) || User.create_with_omniauth_facebook(auth)
    end
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Succesfully logged in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Succesfully logged out!"
  end
  
end
