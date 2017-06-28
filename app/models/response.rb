class Response < ApplicationRecord
  belongs_to :micropost
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: { maximum: 140 }
end
