class Tour < ApplicationRecord
  belongs_to :user
  has_many :locations
  mount_uploader :photo, PhotoUploader
  CATEGORIES = ["Bachelor Party", "Team buidling", "Kids", "Rainy day", "Sightseeing"]

  scope :category, -> (category) { where category: category }
  scope :duration, -> (duration) { where("duration < ?", duration) }
  scope :price,    -> (price)    { where("price < ?", price) }

end
