module NotificationsHelper

  def notification_form(notification)
    @message = nil
    visiter = link_to notification.name, user_path(notification.visiter_id), style:"font-weight: bold;"
    your_post = link_to 'あなたの投稿', notification.micropost, style:"font-weight: bold;", remote: true
    unless visiter == current_user
      case notification.action
        when "favorite" then
          "#{visiter}が#{your_post}をお気に入り登録しました"
        when "message" then
          @message = Message.find_by(id: notification.message_id).content
          "#{visiter}から相談メールが届きました"
      end
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

end
