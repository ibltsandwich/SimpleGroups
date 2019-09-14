class Api::CommentsController < ApplicationController 
  skip_before_action :verify_authenticity_token

  def index

  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.username = current_user.username
    @comment.post_id = params[:post_id]

    if @comment.save
      render json: @comment
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

  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end
end