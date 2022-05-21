class SessionsController < ApplicationController
  if Rails.env.development?
    skip_before_action :verify_authenticity_token, only: :create
  end

  def new
    render :new
  end

  def create
    #user_info = request.env['omniauth.auth']
    redirect_to root_url, notice: "Logged in."
  end

  def destroy
    redirect_to root_url, notice: "Logged out."
  end
end