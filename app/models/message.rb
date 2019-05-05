class Message < ApplicationRecord
  belongs_to :user
  belongs_to :receive_user, class_name: 'User'
  has_many :notifications,dependent: :destroy
  default_scope->{order(created_at: :desc)}
  
  # メッセージが送信されたとき(messages#createが実行されたとき)に、notificationテーブルにメール通知が登録される
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      message_id: self.id,
      visited_id: self.user.id,
      action: "message"
    )
    notification.save if notification.valid?
  end
  
end
