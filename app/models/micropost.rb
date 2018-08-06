class Micropost < ApplicationRecord
  belongs_to :user
  default_scope ->{order(created_at: :desc)}
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate  :picture_size

  scope :feed_user_id, ->(id){where user_id: id}

  private
  def picture_size
    return unless picture.size > 100.kilobytes
    errors.add(:picture, "should be less than 5MB")
  end
end
