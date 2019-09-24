class College < ApplicationRecord
    has_many :users, dependent: :destroy
    validates :name, presence: true
    validates :last_email, presence: true
end
