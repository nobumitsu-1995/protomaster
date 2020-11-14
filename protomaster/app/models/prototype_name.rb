class PrototypeName < ApplicationRecord
  validates :name , presence: true
  validates :formtype , presence: true
end
