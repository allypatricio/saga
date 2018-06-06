class Review < ApplicationRecord
  belongs_to :booking

  validates :content, presence: true
  validates :rating, presence: true, inclusion: { in: (0..5).to_a }, numericality: { only_integer: true }
end
