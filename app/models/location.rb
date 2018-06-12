class Location < ApplicationRecord
  belongs_to :tour
  acts_as_list scope: :tour

  geocoded_by :address
  before_validation :geocode, if: :will_save_change_to_address?

  mount_uploader :photo, PhotoUploader

  validates :address, presence: true
  validates :story, presence: true, length: { in: (20..60) }
  validates :latitude, presence: true
  validates :longitude, presence: true
end
