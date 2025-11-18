class RoomType < ApplicationRecord
  belongs_to :accommodation
  has_one_attached :image

  validates :name,        presence: true
  validates :capacity,    presence: true
  validates :base_price,  presence: true
  validates :description, presence: true

  validates :name, uniqueness: { scope: :accommodation_id }
end
