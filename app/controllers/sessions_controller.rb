class SessionsController < ApplicationController
  if Rails.env.development?
    skip_before_action :verify_authenticity_token, only: :create
  end

  def new
    render :new
  end

  def create
    user_info = request.env['omniauth.auth']
    auth      = Authorization.find_by(provider: user_info.provider, uid: user_info.uid)

    if auth then
      session[:current_user_id] = auth.user_id
      redirect_to root_url, notice: "Logged in."
    else
      redirect_to root_url, notice: "You must join our Discord before registering on the website."
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_url, notice: "Logged out."
  end
end