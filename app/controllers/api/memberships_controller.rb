class Api::MembershipsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @group = Group.includes(:members).find(params[:id])
    @members = @group.members

    render json: {group: @group, members: @members}
  end

  def create
    @membership = Membership.new()
    @user = current_user
    @group = Group.find(params[:group_id])

    @membership.user_id = @user.id
    @membership.group_id = @group.id

    if @membership.save!
      render json: {id: current_user.id, username: current_user.username}, status: 200
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

   if @membership.destroy
    @members = []
    @group = Group.includes(:members).find(params[:group_id])

    @group.members.each do |member|
      @members << {id: member.id, username: member.username}
    end

    render json: @members
   end
  end

end