class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, presence: true

  enum role: { trainee: 0, admin: 1 }

  # Friendships I sent
  has_many :sent_friendships,
          class_name: "Friendship",
          foreign_key: "requester_id",
          dependent: :destroy

  # Friendships I received
  has_many :received_friendships,
          class_name: "Friendship",
          foreign_key: "receiver_id",
          dependent: :destroy

  # All accepted friendships
  def friends
    sent_friendships.where(status: "accepted").map(&:receiver) +
    received_friendships.where(status: "accepted").map(&:requester)
  end

  # Pending invitations I sent
  def pending_sent_invitations
    sent_friendships.where(status: "pending")
  end

  # Pending invitations I received
  def pending_received_invitations
    received_friendships.where(status: "pending")
  end

end
