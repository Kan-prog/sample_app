module ApplicationHelper
  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "tradents"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  # def user_name
  #   if @user.email.split("@").last == @user.college.last_email
  #     permit_name = fa_icon("check-circle", text: @user.name)
  #     user_name = permit_name
  #     puts user_name
  #   else  
  #     user_name = @user.name
  #     puts user_name
  #   end
  # end
end
