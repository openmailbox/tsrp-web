class ApplicationController < ActionController::Base
  before_action :require_login

  def current_user
    @current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end

  private

  def require_login
    unless current_user then
      redirect_to root_url, notice: "You must be logged in."
      return
    end
  end
end
