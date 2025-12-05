class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reservation

  MIN_RATING = 1
  MAX_RATING = 5
  RATING_RANGE = MIN_RATING..MAX_RATING

  validates :reservation_id, uniqueness: { scope: :user_id }
  validates :rating, numericality: { only_integer: true, in: RATING_RANGE }
  validates :comment, presence: true
end
