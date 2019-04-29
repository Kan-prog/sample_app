class MicropostGenre < ApplicationRecord
  belongs_to :micropost
  belongs_to :genre
end
