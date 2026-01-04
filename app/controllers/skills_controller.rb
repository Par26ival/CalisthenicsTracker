class SkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_skill, only: [:show]

  def index
    @skills = Skill
                .includes(posts: :ratings)
                .order(:name)
  end

  def show
    @posts = @skill.posts
                   .includes(:user, :skills, :ratings, media_attachments: :blob)
                   .order(created_at: :desc)
  end

  private

  def set_skill
    @skill = Skill.find(params[:id])
  end
end
