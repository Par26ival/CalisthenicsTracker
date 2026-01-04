class Skill < ApplicationRecord
  has_many :post_skills, dependent: :destroy
  has_many :posts, through: :post_skills

  validates :name, presence: true, uniqueness: true, length: { maximum: 80 }

  def attempts_count
    posts.count
  end

  def weighted_score
    rated_posts = posts.includes(:ratings).select { |p| p.average_rating.present? }
    return nil if rated_posts.empty?

    now = Time.current
    weighted_sum = 0.0
    weight_total = 0.0

    rated_posts.each do |post|
      days_old = ((now - post.created_at) / 1.day).to_i
      weight = 1.0 / (1.0 + days_old)

      weighted_sum += post.average_rating * weight
      weight_total += weight
    end

    (weighted_sum / weight_total).round(2)
  end
end
