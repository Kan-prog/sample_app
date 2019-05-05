class ChangeColumnToMicropost < ActiveRecord::Migration[5.1]
  def up
    change_column_default(:microposts, :sold, false)
  end
  
  def down
    change_column_default(:microposts, :sold, nil)
  end
end
