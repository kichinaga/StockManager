class User < ApplicationRecord
  has_many :stocks, dependent: :destroy

  before_save :downcase_email

  ## validations
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  ## functions
  private
    def downcase_email
      self.email.downcase!
    end
end
