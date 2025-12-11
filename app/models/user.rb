class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :validatable

  validates :username, presence: true

  enum role: { trainee: 0, admin: 1 }
end
