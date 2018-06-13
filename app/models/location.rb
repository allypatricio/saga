class Location < ApplicationRecord
  belongs_to :tour
  acts_as_list scope: :tour

  geocoded_by :address
  before_validation :geocode, if: :will_save_change_to_address?

  validates :address, presence: true
  validates :story, presence: true, length: { in: (10..100) }, on: :update
  validates :latitude, presence: true
  validates :longitude, presence: true
end
