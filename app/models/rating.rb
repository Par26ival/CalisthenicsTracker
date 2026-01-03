class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :score, inclusion: { in: 1..5 }
  validates :user_id, uniqueness: { scope: :post_id }
end
