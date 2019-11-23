class User < ApplicationRecord
  has_many :chords
  has_secure_password
  validates :username, uniqueness: { case_sensitive: false }, presence: true
  validates :password, presence: true
end
