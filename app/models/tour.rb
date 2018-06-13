class Tour < ApplicationRecord
  CATEGORIES = ["Bachelor Party", "Team building", "Kids", "Rainy day", "Sightseeing"]

  belongs_to :user
  has_many :locations, -> { order(position: :asc) }, dependent: :destroy
  enum status: [:inactive, :active]

  mount_uploader :photo, PhotoUploader

  scope :category, -> (category) { where category: category }
  scope :duration, -> (duration) { where("duration < ?", duration) }
  scope :price,    -> (price)    { where("price < ?", price) }
  scope :location, -> (location) { includes(:locations).where("locations.address like ?", "%#{location.capitalize}%").references(:locations) }

  validates :title, presence: true, length: { in: (8..30) }
  validates :description, presence: true, length: { in: (40..200) }
  validates :price, presence: true, on: :update
  validates :duration, presence: true, on: :update
  validates :category, presence: true, on: :update

  def activate
    update_attributes(status: :active)

  end

  def disactivate
    update_attributes(status: :inactive)
  end

end
