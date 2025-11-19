class RoomType < ApplicationRecord
  belongs_to :accommodation
  has_many :room_inventories, dependent: :destroy
  has_many :reservations, dependent: :restrict_with_exception
  has_one_attached :image

  validates :name, presence: true, uniqueness: { scope: :accommodation_id }
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :base_price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true
end
