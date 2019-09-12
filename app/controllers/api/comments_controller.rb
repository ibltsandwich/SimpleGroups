class Api::CommentsController < ApplicationController 
  def index

  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save

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
    params.require(:comment).permit(:body, :user_id, :post_id)
  end
end