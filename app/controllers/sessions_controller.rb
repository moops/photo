class SessionsController < ApplicationController
  # GET /sessions/new
  def new; end

  # POST /sessions
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'logged in. nice'
    else
      redirect_to root_url, alert: 'email or password is invalid'
    end
  end

  # DELETE /sessions
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'logged out. see ya'
  end
end
