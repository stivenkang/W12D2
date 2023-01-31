class Api::SessionsController < ApplicationController
  def show
    @user = current_user
    if @user
      render 'api/users/show'
    else
      render json: {user: nil}
    end
  end

  def create
    username = params[:username]
    email = params[:email]
    credential = [username: username, email: email]
    password = params[:password]
    debugger

    @user = User.find_by_credentials(credential, password)
    if @user 
      login!(@user)
      render 'api/users/show'
    else
      render json: {errors: ['Invalid Credentials']}, status: 418
    end
  end

  def destroy
    if @user 
      logout!
      render json: {message: 'success'}
    end
  end

end
