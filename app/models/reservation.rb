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
end
