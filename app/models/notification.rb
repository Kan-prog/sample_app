class Notification < ApplicationRecord
  default_scope->{order(created_at: :desc)}
  belongs_to :micropost, optional: true
  belongs_to :message, optional: true
end
