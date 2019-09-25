class Record < ApplicationRecord
  belongs_to :user
  mount_uploader :img, ImgUploader
  validates :content, presence: true, numericality: true, length: { maximum: 50 }
  validates :date, presence: true
end
