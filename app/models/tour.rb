class Tour < ApplicationRecord
after_create :default_image

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
  validates :description, presence: true, length: { in: (40..400) }
  validates :price, presence: true, inclusion: { in: (0..100) }, on: :update
  validates :duration, presence: true, inclusion: { in: (0..10) }, on: :update
  validates :category, presence: true, on: :update

  def activate
    update_attributes(status: :active)

  end

  def disactivate
    update_attributes(status: :inactive)
  end


  def default_image
    if self.photo.url.nil?
      self.remote_photo_url = "https://images.unsplash.com/photo-1519789110007-0e751882be76?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=ffcb4d8d9dff9ef47b3330b7fa63b162&auto=format&fit=crop&w=1458&q=80"
    end
  end
end
