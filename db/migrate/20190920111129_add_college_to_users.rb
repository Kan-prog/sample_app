class AddCollegeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :college, foreign_key: true
    add_index :colleges, [:name, :last_email]
  end
end
