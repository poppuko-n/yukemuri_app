class RoomType < ApplicationRecord
  belongs_to :accommodation
  has_many :room_inventories, dependent: :destroy
  has_many :reservations, dependent: :restrict_with_error
  has_one_attached :image

  validates :name, presence: true, uniqueness: { scope: :accommodation_id }
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :base_price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true

  validate :validate_image_presence

  private

  def validate_image_presence
    errors.add(:image, :validate_image_presence) unless image.attached?
  end
end
