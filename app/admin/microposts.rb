ActiveAdmin.register Micropost do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :content, :user_id, :picture, :price, :cost, :sold, :name, :picture_1, :picture_2, :picture_3
  #
  # or
  #
  # permit_params do
  #   permitted = [:content, :user_id, :picture, :price, :cost, :sold, :name, :picture_1, :picture_2, :picture_3]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
