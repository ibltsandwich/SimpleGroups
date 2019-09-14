class Api::MembershipsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @group = Group.includes(:members).find(params[:id])
    @members = @group.members

    render json: {group: @group, members: @members}
  end

  def create
    @membership = Membership.new()
    @membership.user_id = current_user.id
    @group = Group.find(params[:group_id])
    @membership.group_id = @group.id

    if @membership.save!
      render json: @group, status: 200
    else
      render json: ['Could not join'], status: 422
    end

  end

  def show 

  end

  def update

  end

  def destroy
    @membership = Membership.find_by(user_id: current_user.id, group_id: params[:group_id])

    @membership.destroy
  end

end