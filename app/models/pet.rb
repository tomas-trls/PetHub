class Pet < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_one_attached :photo
  geocoded_by :address, through: :user
  after_validation :geocode, if: :will_save_change_to_address?
end
