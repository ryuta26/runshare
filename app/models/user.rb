class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :records
  
  validate :birthday_cannot_be_in_the_future
  
  def birthday_cannot_be_in_the_future
    if birthday.present? && birthday.future?
      errors.add(:birthday, "：未来の日付は使用できません")
    end
  end
end
