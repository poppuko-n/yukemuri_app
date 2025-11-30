class Reservation < ApplicationRecord
  extend Enumerize

  belongs_to :user
  belongs_to :room_type
  has_many :reviews, dependent: :destroy

  RESERVATION_STATUSES = %w[confirmed checked_out cancelled].freeze
  MIN_NIGHTS = 1
  MAX_NIGHTS = 5
  NIGHT_RANGE = MIN_NIGHTS..MAX_NIGHTS
  MIN_CHECK_IN_DAYS = 1
  MAX_CHECK_IN_DAYS = 90
  NIGHT_RANGE = MIN_NIGHTS..MAX_NIGHTS

  enumerize :status, in: RESERVATION_STATUSES, predicates: true

  validates :check_in_date, presence: true
  validates :night_count, presence: true, numericality: { only_integer: true, in: NIGHT_RANGE }
  validates :adult_count, numericality: { only_integer: true, greater_than: 0 }
  validates :child_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :total_amount, numericality: { only_integer: true, greater_than: 0 }
  validates :status, presence: true

  validate :validate_check_in_date_range
  validate :validate_room_inventory
  validate :validate_total_guest_count

  after_create :use_room!

  scope :default_order, -> { order(check_in_date: :desc, id: :desc) }

  def calculate_total_amount
    return if night_count.blank? || adult_count.blank? || child_count.blank?

    subtotal = adult_amount + child_amount
    self.total_amount = Tax.calculate_with_tax(subtotal).to_i
  end

  def cancellable?
    confirmed? && check_in_date > Date.current + 1.day
  end

  def cancel!
    raise unless cancellable?

    transaction do
      update_column(:status, 'cancelled')
      release_room!
    end
  end

  def reviewable?
    reviews.blank? && checked_out?
  end

  def admin_cancel!
    transaction do
      update_column(:status, 'cancelled')
      release_room!
    end
  end

  def admin_confirm!
    transaction do
      update!({ status: 'confirmed' })
      use_room!
    end
  end

  def admin_check_out!
    update_column(:status, 'checked_out')
  end

  private

  def base_price_decimal
    BigDecimal(room_type.base_price.to_s)
  end

  def adult_amount
    base_price_decimal * BigDecimal(night_count.to_s) * BigDecimal(adult_count.to_s)
  end

  def child_amount
    child_unit = PricingRule.child_price(base_price_decimal)
    child_unit * BigDecimal(night_count.to_s) * BigDecimal(child_count.to_s)
  end

  def validate_check_in_date_range
    range = (Date.current + MIN_CHECK_IN_DAYS.days)..(Date.current + MAX_CHECK_IN_DAYS)

    errors.add(:check_in_date, :validate_check_in_date_range) unless range.include?(check_in_date)
  end

  def validate_room_inventory
    return if check_in_date.blank? || night_count.blank?

    inventories_by_date = room_type.room_inventories.where(date: stay_date_range).index_by(&:date)

    unavailable = stay_date_range.any? do |date|
      inventory = inventories_by_date[date]
      inventory.nil? || inventory.remaining_room <= 0
    end

    errors.add(:night_count, :validate_room_inventory) if unavailable
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
    (check_in_date...(check_in_date + night_count.days)).to_a
  end

  def use_room!
    stay_date_range.each do |date|
      room_type.room_inventories.lock.find_by!(date: date).use_room!
    end
  end

  def release_room!
    stay_date_range.each do |date|
      room_type.room_inventories.lock.find_by!(date: date).release_room!
    end
  end
end
