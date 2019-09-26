class UserMailer < ApplicationMailer
  
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "アカウント有効化メール from:Tradents"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワード再設定メール from:Tradents"
  end
end
