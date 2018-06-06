class Tour < ApplicationRecord
  CATEGORIES = ["Bachelor Party", "Team buidling", "Kids", "Rainy day", "Sightseeing"]
  belongs_to :user
  has_many :locations

  mount_uploader :photo, PhotoUploader

  scope :category, -> (category) { where category: category }
  scope :duration, -> (duration) { where("duration > ? AND duration < ?", duration.split(",").first, duration.split(",").last) }
  scope :price,    -> (price)    { where("price > ? AND price < ?", price.split(",").first, price.split(",").last) }

  validates :title, presence: true, length: { in: (8..25) }
  validates :description, presence: true, length: { in: (40..200) }
  # validates :price, presence: true, on: :update
  # validates :duration, presence: true, on: :update
  # validates :category, presence: true, on: :update
end
