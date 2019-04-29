class Genre < ApplicationRecord
    validates :name, presence: true,
                     uniqueness: true
    has_many :micropost_genres
    has_many :microposts, through: :micropost_genres, source: :micropost
end
