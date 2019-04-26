class Micropost < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :like_users, through: :favorites, source: :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :name, presence: true
  validates :cost, numericality: { only_integer: true }
  validates :price, numericality: { only_integer: true }
  validates :content, presence: true, length: { maximum: 255 }
  validate :picture_size
  
  private

    # アップロード画像のサイズを検証する
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "5MB以下の容量の画像のみお使いいただけます。")
      end
    end
end
