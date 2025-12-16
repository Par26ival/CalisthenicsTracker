class Friendship < ApplicationRecord
  belongs_to :requester, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates :status, inclusion: { in: ["pending", "accepted"] }
  validates :requester_id, uniqueness: { scope: :receiver_id,
                                         message: "already invited this user" }

  validate :cannot_friend_self

  def accept!
    update(status: "accepted")
  end

  private

  def cannot_friend_self
    errors.add(:receiver_id, "can't be yourself") if requester_id == receiver_id
  end
end
