class NotificationMailer < ApplicationMailer

  def notification_mail(receive_user, send_user, message)
    @receive_user = receive_user
    @send_user = send_user
    @message = message
    mail to: @receive_user.email, subject: "#{@send_user.display_name}から相談メールが届きました。確認してみましょう"
  end
end
