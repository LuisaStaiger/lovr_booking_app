require 'date'

class StripeCheckoutSessionService
  def call(event)
    booking = Booking.find_by(checkout_session_id: event.data.object.id)
    booking.update(status: 1)
    remove_overlapping_slot(booking)
    end

    def remove_overlapping_slot(booking)
      double_slot = AvailableSlot.all.find do |slot|
        slot.date == booking.booking_date &&
        slot.start_time == booking.start_time &&
        slot.love_pod == booking.available_slot.love_pod
      end

      if double_slot.present?
        if booking.duration == 55 && double_slot.duration == 25
          overlapping_slot = AvailableSlot.all.find do |slot|
            slot.date == booking.booking_date &&
            slot.start_time == booking.start_time + 30.minutes &&
            slot.duration == 25 &&
            slot.love_pod == booking.available_slot.love_pod
          end

          overlapping_slot.destroy if overlapping_slot.present?
          
          else
            double_slot.destroy
        end
      end
    end
end
