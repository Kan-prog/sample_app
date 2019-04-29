class Micropost < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :like_users, through: :favorites, source: :user
  has_many :micropost_genres, dependent: :destroy
  has_many :genres, through: :micropost_genres, source: :genre
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :name, presence: true
  validates :cost, numericality: { only_integer: true }
  validates :price, numericality: { only_integer: true }
  validates :content, presence: true, length: { maximum: 255 }
  validate :picture_size
  
  accepts_nested_attributes_for :micropost_genres, allow_destroy: true
  
  private

    # アップロード画像のサイズを検証する
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "5MB以下の容量の画像のみお使いいただけます。")
      end
    end
end
