class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many_attached :media

  validates :content, presence: true, length: { maximum: 1000 }

  validate :media_type_and_size

  private

  def media_type_and_size
    media.each do |file|
      if !file.content_type.in?(%w[image/jpeg image/png image/webp video/mp4 video/webm])
        errors.add(:media, "must be an image or video")
      elsif file.byte_size > 50.megabytes
        errors.add(:media, "is too large (max 50MB)")
      end
    end
  end
end
