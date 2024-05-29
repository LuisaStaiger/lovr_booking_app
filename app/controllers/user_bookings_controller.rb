class UserBookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings
    @confirmed_bookings = @bookings.where(status: 1)
  end

  def destroy
  end
end
