class RoomInventory < ApplicationRecord
  belongs_to :room_type

  validates :date, presence: true, uniqueness: { scope: :room_type_id }
  validates :remaining_room, presence: true, numericality: { greater_than_or_equal_to: 0 }

  attribute :diff, :integer, default: 0

  scope :default_order, -> { order(:date) }

  def use_room!
    update!(remaining_room: remaining_room - 1)
  end

  def release_room!
    update!(remaining_room: remaining_room + 1)
  end

  def apply_diff(diff)
    with_lock do
      new_inventory = remaining_room + diff

      if new_inventory < 0
        errors.add(:diff, :validate_update_diff)
        return false
      end

      update(remaining_room: new_inventory)
    end
  end
end
