class CreateColleges < ActiveRecord::Migration[5.1]
  def change
    create_table :colleges do |t|
      t.text :name
      t.text :last_email

      t.timestamps
    end
  end
end
