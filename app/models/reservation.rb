class Reservation < ApplicationRecord
  extend Enumerize

  belongs_to :user
  belongs_to :room_type

  RESERVATION_STATUSES = %w[confirmed checked_out cancelled].freeze
  MIN_NIGHTS = 1
  MAX_NIGHTS = 5
  NIGHT_RANGE = MIN_NIGHTS..MAX_NIGHTS
  MIN_CHECK_IN_DAYS = 1
  MAX_CHECK_IN_DAYS = 90
  NIGHT_RANGE = MIN_NIGHTS..MAX_NIGHTS

  enumerize :status, in: RESERVATION_STATUSES, predicates: true

  validates :check_in_date, presence: true
  validates :night, presence: true, numericality: { only_integer: true, in: NIGHT_RANGE }
  validates :adult_count, numericality: { only_integer: true, greater_than: 0 }
  validates :child_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :total_amount, numericality: { only_integer: true, greater_than: 0 }
  validates :status, presence: true

  validate :validate_check_in_date_range
  validate :validate_room_inventory
  validate :validate_total_guest_count

  private

  def validate_check_in_date_range
    range = (Date.current + MIN_CHECK_IN_DAYS.days)..(Date.current + MAX_CHECK_IN_DAYS)

    errors.add(:check_in_date, :validate_check_in_date_range) unless range.include?(check_in_date)
  end

  def validate_room_inventory
    return if check_in_date.blank? || night.blank?

    inventories_by_date = room_type.room_inventories.where(date: stay_date_range).index_by(&:date)

    unavailable = stay_date_range.any? do |date|
      inventory = inventories_by_date[date]
      inventory.nil? || inventory.remaining_room <= 0
    end

    errors.add(:night, :validate_room_inventory) if unavailable
  end

  def validate_total_guest_count
    return if adult_count.blank? || child_count.blank?

    total_guests = adult_count + child_count
    if total_guests > room_type.capacity
      errors.add(:adult_count, :validate_total_guest_count)
      errors.add(:child_count, :validate_total_guest_count)
    end
  end

  def stay_date_range
    (check_in_date...(check_in_date + night.days)).to_a
  end
end
