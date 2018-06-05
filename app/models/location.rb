class Location < ApplicationRecord
  belongs_to :tour

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  mount_uploader :photo, PhotoUploader

end
