class Tour < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  belongs_to :user
  has_many :locations
  mount_uploader :photo, PhotoUploader
end
