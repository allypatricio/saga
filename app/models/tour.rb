class Tour < ApplicationRecord
  belongs_to :user
  has_many :locations
  mount_uploader :photo, PhotoUploader
  CATEGORIES = ["Bachelor Party", "Team buidling", "Kids", "Rainy day", "Sightseeing"]

  scope :category, -> (category) { where category: category }
  scope :duration, -> (duration) { where("duration > ? AND duration < ?", duration.split(",").first, duration.split(",").last) }
  scope :price,    -> (price)    { where("price > ? AND price < ?", price.split(",").first, price.split(",").last) }

end
