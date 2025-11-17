class Accommodation < ApplicationRecord
  extend Enumerize

  ACCOMMODATION_CATEGORY = %w[guest_house inn hotel].freeze

  enumerize :category, in: ACCOMMODATION_CATEGORY
  enumerize :prefecture, in: Prefecture::LIST

  validate :prefecture, presence: true
  validate :name, presence: true
  validate :address, presence: true
  validate :phone_number, presence: true, format: { with: /\A0\d{1,4}-?\d{1,4}-?\d{4}\z/  }
  validate :category, presence: true
  validate :description, presence: true
  validate :name, uniqueness: { scope: :address }

  scope :published, -> { where(published: true) }
end
