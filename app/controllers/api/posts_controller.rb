class Api::PostsController < ApplicationController
  def index

  end

  def create
    @post = Post.new(post_params)

    if @post.save

    else

    end
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @comments = @post.comments

    render json: {post: @post, comments: @comments}
  end

  def update

  end

  def destroy

  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :group_id)
  end
end