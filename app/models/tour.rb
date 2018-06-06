class Tour < ApplicationRecord
  CATEGORIES = ["Bachelor Party", "Team buidling", "Kids", "Rainy day", "Sightseeing"]
  belongs_to :user
  has_many :locations

  mount_uploader :photo, PhotoUploader

  scope :category, -> (category) { where category: category }
  scope :duration, -> (duration) { where("duration < ?", duration) }
  scope :price,    -> (price)    { where("price < ?", price) }
  scope :location, -> (location) { includes(:locations).where("locations.address like ?", "%#{location}%").references(:locations) }

  validates :title, presence: true, length: { in: (8..25) }
  validates :description, presence: true, length: { in: (40..200) }
  # validates :price, presence: true, on: :update
  # validates :duration, presence: true, on: :update
  # validates :category, presence: true, on: :update
end
