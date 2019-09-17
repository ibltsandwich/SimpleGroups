class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      render json: {id: @user.id, username: @user.username}
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def show 
    @user = User.includes(:groups, :owned_groups).find(params[:id])
    @groups = @user.groups
    @owned_groups = @user.owned_groups

    if @user
      render json: {
        id: @user.id, 
        username: @user.username, 
        groups: @groups, 
        owned_groups: @owned_groups
      }
    end

  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end