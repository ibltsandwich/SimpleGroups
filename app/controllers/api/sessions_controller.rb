class Api::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create 
    @user = User.includes(:groups).find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      login(@user)
      render json: {id: @user.id, username: @user.username}, status: 200
    else
      render json: ['Invalid username or password'], status: 422
    end
  end

  def show 
    @user = current_user

    if @user
      render json: {id: @user.id, username: @user.username, exists: true}, status: 200
    else
      render json: {exists: false}
    end
  end

  def destroy
    @user = current_user
    if @user
      logout
    else
      render json: ['No user signed in'], status: 404
    end
  end
end