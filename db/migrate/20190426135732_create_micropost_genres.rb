class CreateMicropostGenres < ActiveRecord::Migration[5.1]
  def change
    create_table :micropost_genres do |t|
      t.references :micropost, foreign_key: true
      t.references :genre, foreign_key: true

      t.timestamps
      
      t.index [:micropost_id, :genre_id], unique: true
    end
  end
end
