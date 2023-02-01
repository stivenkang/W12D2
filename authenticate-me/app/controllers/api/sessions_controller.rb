class Api::SessionsController < ApplicationController
  before_action :require_logged_in, only: [:create]
  before_action :require_logged_in, only: [:destroy]

  def show
    @user = current_user
    if @user
      render 'api/users/show'
    else
      render json: {user: nil}
    end
  end

  def create
    credential = params[:credential]
    password = params[:password]
    # debugger
    @user = User.find_by_credentials(credential, password)
    if @user 
      login!(@user)
      render 'api/users/show'
    else
      render json: {errors: ['Invalid Credentials']}, status: 418
    end
  end

  def destroy
    if current_user
      logout!
      render json: {message: 'success'}
    end
  end

end
