class PostsController < ApplicationController

  before_action :find_post, only: %i[show destroy like]
  before_action :authenticate_user!, only: %i[show index]
  skip_before_action :verify_authenticity_token
  include Devise::Controllers::Helpers


  def index
    @posts = Post.all.sort.reverse
  end

  def create
#    post = Post.create(posts_params)
    post = Post.new(params[:post])
    post.user = current_user
    post.content = params[:content]
    post.save
    redirect_to posts_path
  end

  def show
    @post
  end

  def edit; end

  def update; end

  def destroy
    if @post.destroy.destroyed?
      redirect_to posts_path
    end
  end

  def like
    @post.increment! :likes_count
    redirect_to posts_path
  end

  private

  def posts_params
    params.require(:post).permit(:content, :user_id)
  end

  def find_post
    @post = Post.where(id: params[:id]).first
  end
end
