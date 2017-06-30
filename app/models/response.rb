class Response < ApplicationRecord
  belongs_to :micropost
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: { maximum: 140 }
  validates :comment_user_id, presence: true
  validates :micropost_id, presence: true
end
