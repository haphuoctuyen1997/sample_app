class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size
  default_scope ->{order(created_at: :desc)}

  scope :feed_user_id, ->(following_ids, id){where("user_id IN (?) OR user_id = ?", following_ids, id)}

  private
  def picture_size
    return unless picture.size > 100.kilobytes
    errors.add(:picture, t(".micropost.picture_error"))
  end
end
