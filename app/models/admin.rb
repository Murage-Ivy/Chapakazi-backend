class Admin < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { maximum: 3 }
  validates :password_confirmation, presence: true, length: { maximum: 3 }
  has_many :customers
  has_many :handymen
end
