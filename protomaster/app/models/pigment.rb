class Pigment < ApplicationRecord
  validates :code , {uniqueness: true}
end
