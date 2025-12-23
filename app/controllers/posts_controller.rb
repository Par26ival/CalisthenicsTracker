class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :destroy]
  before_action :authorize_destroy!, only: [:destroy]

  def index
    @posts = Post.includes(:user, :comments).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: "Post created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.new
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post deleted"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_destroy!
    return if current_user.admin? || @post.user == current_user

    redirect_to posts_path, alert: "You are not allowed to delete this post"
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
