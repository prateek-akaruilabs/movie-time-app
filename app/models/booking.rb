class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :show
  has_many :payments

  before_create :set_booking_id

  def set_booking_id
    self.booking_id = "#{SecureRandom.uuid}"
  end

  def cinema
    show.screen.cinema
  end
end
