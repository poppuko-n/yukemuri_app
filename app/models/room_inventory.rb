class RoomInventory < ApplicationRecord
  belongs_to :room_type

  validates :date, presence: true, uniqueness: { scope: :room_type_id }
  validates :remaining_room, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :default_order, -> { order(:date) }
end
