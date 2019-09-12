class Api::GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def create
    @group = Group.new(group_params)

    if @group.save

    else

    end
  end


  def show
    
  end

  def update

  end

  def destroy

  end

  private

  def group_params
    params.require(:group).permit(:name, :owner_id)
  end
end