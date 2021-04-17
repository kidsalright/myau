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
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: "Post was successfully created." }
        format.json { render posts_path, status: :created }
      else
        format.html { render posts_path, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @post
  end

  def edit; end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_path, notice: "Post was successfully updated." }
        format.json { render posts_path, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
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
