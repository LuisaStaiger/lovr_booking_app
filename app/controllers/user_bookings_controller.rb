class UserBookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    
    @bookings = current_user.bookings.includes(:festival, :love_pod)
  end
end
