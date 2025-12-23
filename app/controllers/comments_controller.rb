class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:destroy]
  before_action :authorize_destroy!, only: [:destroy]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: "Comment added"
    else
      redirect_to post_path(@post), alert: "Comment cannot be empty"
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post), notice: "Comment deleted"
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def authorize_destroy!
    return if current_user.admin? || @comment.user == current_user

    redirect_to post_path(@post), alert: "You are not allowed to delete this comment"
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
