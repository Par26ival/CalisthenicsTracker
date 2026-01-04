class Skill < ApplicationRecord
  has_many :post_skills, dependent: :destroy
  has_many :posts, through: :post_skills

  validates :name, presence: true, uniqueness: true, length: { maximum: 80 }
end
