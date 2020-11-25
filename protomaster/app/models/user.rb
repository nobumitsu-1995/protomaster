class User < ApplicationRecord
  has_secure_password
  validates :number , {presence: true , uniqueness: true}
  validates :name , :password_digest , {presence: true}
end
