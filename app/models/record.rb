class Record < ApplicationRecord
  belongs_to :user
  mount_uploader :img, ImgUploader
  validates :content, presence: true, numericality: true, length: { maximum: 50 }
  validates :date, presence: true
  validates :comment, length: { maximum: 50 }
  
   validate :date_cannot_be_in_the_future

def date_cannot_be_in_the_future
  if date.present? && date > Date.today
    errors.add(:date, "：未来の日付は使用できません")
  end
end
  
end
