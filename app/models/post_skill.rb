class PostSkill < ApplicationRecord
  belongs_to :post
  belongs_to :skill

  validates :skill_id, uniqueness: { scope: :post_id }
end
