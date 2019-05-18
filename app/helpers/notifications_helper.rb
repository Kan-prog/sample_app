module NotificationsHelper

  def notification_form(notification)
    @message = nil
    @visiter = User.find_by(id: notification.visiter_id)
    @your_post = link_to "あなたの投稿", notification.micropost, style:"font-weight: bold;", remote: true
    @message = Message.find_by(id: notification.message_id)
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

end
