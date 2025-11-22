class Accommodation < ApplicationRecord
  extend Enumerize

  ACCOMMODATION_CATEGORY = %w[guest_house inn hotel].freeze

  has_many :room_types, dependent: :destroy
  has_one_attached :image

  enumerize :category, in: ACCOMMODATION_CATEGORY
  enumerize :prefecture, in: Prefecture::LIST

  validates :prefecture, presence: true
  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A0\d{1,4}-?\d{1,4}-?\d{4}\z/ }
  validates :category, presence: true
  validates :description, presence: true
  validates :name, uniqueness: { scope: :address }

  scope :published, -> { where(published: true) }

  def prefecture_name
    Prefecture::LIST.key(prefecture)
  end
end
