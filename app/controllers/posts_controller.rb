class PostsController < ApplicationController

  def index
    @posts = Post.all.reverse
  end

  def create
    post = Post.create(posts_params)
    redirect_to posts_path
  end

  def new; end

  def show; end

  def edit; end

  def update; end

  def destroy
    post = Post.where(id: params[:id]).first.destroy
    if post.destroyed?
      redirect_to posts_path
    end
  end

  private

  def posts_params
    params.permit(:content)
  end
end
