class RoomInventory < ApplicationRecord
  belongs_to :room_type

  validates :date, presence: true, uniqueness: { scope: :room_type_id }
  validates :remaining_room, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :default_order, -> { order(:date) }

  def use_room!
    update!(remaining_room: remaining_room - 1)
  end

  def release_room!
    update!(remaining_room: remaining_room + 1)
  end
end
