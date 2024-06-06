class UserBookingsController < ApplicationController
  before_action :authenticate_user!, :set_bookings, only: [:index, :expire]

  def index
    expire
    @confirmed_bookings = @bookings.where(status: 1)
    @pending_bookings = @bookings.where(status: 0)
  end

  def destroy
  end

  def expire
    @bookings.each do |booking|
      if booking.status == "pending" && booking.created_at + 30.minutes <= Time.current
        booking.destroy
      end
    end
  end

  private
  def set_bookings
    @bookings = current_user.bookings
  end
end
