class HalfProduct < ApplicationRecord
  validates :code , {uniqueness: true}
end
