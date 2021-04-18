class PostsController < ApplicationController

  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[show index]
  skip_before_action :verify_authenticity_token
  include Devise::Controllers::Helpers


  def index
    @posts = Post.all.sort.reverse
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      puts "gj u broke it"
    end
  end

  def show
    @post
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      puts ")))"
    end
  end

  def destroy
    @post.destroy
  end

  def like
    @post.increment! :likes_count
    redirect_to posts_path
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.permit(:content, :user_id, :picture)
    end
end
