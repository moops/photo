class UsersController < ApplicationController
  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    respond_to do |format|
      format.html {} # new.html.erb
      format.json { render json: @user }
      format.js   {} # new.js.erb
    end
  end

  def create
    @user = User.new(params[:user])
    @user.roles = %w[photographer viewer]
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Thank you for signing up!'
    else
      render 'new'
    end
  end
end
