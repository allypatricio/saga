class Tour < ApplicationRecord
  belongs_to :user
  has_many :locations
  mount_uploader :photo, PhotoUploader
  CATEGORIES = ["Bachelor Party", "Team buidling", "Kids", "Rainy day", "Sightseeing"]
end
