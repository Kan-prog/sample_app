class DropTableAuthorizations < ActiveRecord::Migration[5.1]
  def change
    drop_table :authorizations
  end
end
