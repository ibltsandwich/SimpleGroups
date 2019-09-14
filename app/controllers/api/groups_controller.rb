class Api::GroupsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @groups = Group.all

    render json: @groups
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id

    if @group.save!
      render json: @group
    else
      render json: @group.errors.full_messages, status: 400
    end
  end


  def show
    @group = Group.includes(:posts).find(params[:id])
    @posts = @group.posts

    if @group
      render json: {group: @group, posts: @posts}
    else
      render json: @group.errors.full_messages, status: 404
    end
  end

  def update

  end

  def destroy

  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end