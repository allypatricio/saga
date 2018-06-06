class Location < ApplicationRecord
  belongs_to :tour

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  mount_uploader :photo, PhotoUploader

  validates :address, presence: true
  validates :story, presence: true, length: { in: (20..60) }
  validates :position, presence: true

  # TO DO:
  # Uniqueness of position within tour
  # presence of latitude / longitude before save

end
