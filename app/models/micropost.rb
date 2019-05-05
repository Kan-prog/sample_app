class Micropost < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :like_users, through: :favorites, source: :user
  has_many :micropost_genres, dependent: :destroy
  has_many :genres, through: :micropost_genres, source: :genre
  has_many :notifications,dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  mount_uploader :pictures, PictureUploader
  validates :user_id, presence: true
  validates :name, presence: true
  validates :cost, numericality: { only_integer: true }
  validates :price, numericality: { only_integer: true }
  validates :content, presence: true, length: { maximum: 255 }
  validates :sold, inclusion: {in: [true, false]}, allow_nil: true
  validate :picture_size
  
  
  accepts_nested_attributes_for :micropost_genres, allow_destroy: true
  
  # いいねが押されたとき(favorites#createが実行されたとき)に、notificationテーブルにいいね通知が登録される
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      micropost_id: self.id,
      visited_id: self.user.id,
      action: "favorite"
    )
    notification.save if notification.valid?
  end
  
  private

    # アップロード画像のサイズを検証する
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "5MB以下の容量の画像のみお使いいただけます。")
      end
    end
end
