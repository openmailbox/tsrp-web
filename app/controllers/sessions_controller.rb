class SessionsController < ApplicationController
  skip_before_action :require_login

  if Rails.env.development?
    skip_before_action :verify_authenticity_token, only: :create
  end

  def new
    render :new
  end

  def create
    user_info = request.env['omniauth.auth']
    user      = User.find_or_create_from_auth(user_info)

    if user.valid? then
      session[:current_user_id] = user.id
      redirect_to root_url, notice: "Logged in."
    else
      redirect_to root_url, notice: user.errors.where(:base).first.full_message
    end
  end

  def destroy
    session.delete(:current_user_id)
    redirect_to root_url, notice: "Logged out."
  end
end