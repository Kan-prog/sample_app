class AddPicturesToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :picture_1, :string
    add_column :microposts, :picture_2, :string
    add_column :microposts, :picture_3, :string
  end
end
