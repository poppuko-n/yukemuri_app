class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :reservations, dependent: :restrict_with_error
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true

  scope :default_order, -> { order(:id) }
end
