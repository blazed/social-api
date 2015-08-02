class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user!

  def show

    if params[:ids]
      @posts = Post.where(id: params[:ids])
      render json: @posts
    else
      @post = Post.where(id: params[:id])
      render json: @post
    end

  end

  def create
    user = User.find_by(id: params[:post][:username])
    @post = user.posts.new(post_params)
    @post.from = current_user

    if @post.save
      render json: @post, status: 200
    else
      render json: { errors: @post.errors.full_messages }, status: 422
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :target, :text)
  end

end
