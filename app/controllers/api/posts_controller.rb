class Api::PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index

  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.username = current_user.username
    @post.group_id = params[:group_id]

    if @post.save
      render json: @post
    else

    end
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @comments = @post.comments

    render json: {post: @post, comments: @comments}
  end

  def update
    @post = Post.find(params[:id])
    @post.body = params[:post][:body]

    if @post.save
      render json: @post
    end
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :group_id)
  end
end