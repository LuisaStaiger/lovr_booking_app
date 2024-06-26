class StripeCheckoutSessionService
  def call(event)
    booking = Booking.find_by(checkout_session_id: event.data.object.id)
    booking.update(status: 1)
    remove_overlapping_slot(booking)
  end
end
