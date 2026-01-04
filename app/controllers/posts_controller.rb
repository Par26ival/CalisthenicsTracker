class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :destroy]
  before_action :authorize_destroy!, only: [:destroy]

  def index
    @skills = Skill.order(:name)

    base = Post
             .includes(:user, :comments, :ratings, :skills, media_attachments: :blob)
             .order(created_at: :desc)

    if params[:skill_id].present?
      @selected_skill = Skill.find(params[:skill_id])
      @posts = base.joins(:skills).where(skills: { id: @selected_skill.id }).distinct
    else
      @posts = base
    end
  end

  def new
    @post = Post.new
    @skills = Skill.order(:name)
  end

  def create
    if current_user.timed_out?
      redirect_to posts_path,
                  alert: "You are temporarily blocked from posting"
      return
    end

    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: "Post created"
    else
      @skills = Skill.order(:name)
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
    @post = Post.includes(:skills, :ratings, :comments, media_attachments: :blob)
                .find(params[:id])
  end

  def authorize_destroy!
    return if current_user.admin? || @post.user == current_user
    redirect_to posts_path, alert: "You are not allowed to delete this post"
  end

  def post_params
    params.require(:post).permit(:content, media: [], skill_ids: [])
  end
end
