class AddPriceToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :price, :integer
    add_column :microposts, :cost, :integer
    add_column :microposts, :sold, :boolean
  end
end
