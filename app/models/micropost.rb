class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  before_save { self.reply_to = reply_user }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size
  
  private
  
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "5MBより小さくしてください")
      end
    end
    
    def reply_user
      if reply_user_id = self.content.match(/@([\d]+)\s/)
        #dの部分の値を返す、数字で
        reply_user_id[1].to_i
      else
        nil
      end
    end
end
