class User < ApplicationRecord
  has_many :stocks

  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }
end
