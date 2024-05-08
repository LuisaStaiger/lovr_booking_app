class UserBookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings
    @slots_booked = []
    @bookings.each do |booking|
      @slots_booked << AvailableSlot.find(booking.available_slot_id)
    end
  end

  def destroy
  end
end
