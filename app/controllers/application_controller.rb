class ApplicationController < ActionController::Base
  
  include Pundit

  protect_from_forgery with: :exception
  
  helper_method :current_user, :admin?

  private

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to request.headers["Referer"] || root_path
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def admin?
      current_user && current_user.admin?
    end
end
