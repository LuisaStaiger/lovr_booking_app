class ClearTemporaryReservationJob < ApplicationJob
  queue_as :default

  def perform(booking_id)
    booking = Booking.find_by(id: booking_id, temporary: true)
    booking.destroy if booking && booking.temporary < Time.current
  end
end
