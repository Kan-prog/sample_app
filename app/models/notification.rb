class Notification < ApplicationRecord
  default_scope->{order(created_at: :desc)}
  belongs_to :micropost, optional: true
  belongs_to :message, optional: true
  belongs_to :visited_user,  class_name: 'User', foreign_key: "visited_id"
  belongs_to :visiter,  class_name: 'User', foreign_key: "visiter_id"
end
