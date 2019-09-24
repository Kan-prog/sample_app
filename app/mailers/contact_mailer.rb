class ContactMailer < ApplicationMailer
default to: 'forwkan@gmail.com' # 送信先アドレス
 
  def contact_mail(contact)
    @contact = contact
    mail(subject: 'webサイトよりメッセージが届きました') do |format|
      format.text
    end
  end
end
