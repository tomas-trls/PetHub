class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :pet
  has_many :reviews
end
