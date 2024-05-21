class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :destroy]
  # before_action :set_festival, only: [:create]
  # before_action :set_love_pod, only: [:create]

  def new
    # @booking = Booking.new
    # # Find the festival based on the festival_id parameter
    @festival = Festival.find(params[:festival_id])
    # Initialize a new booking associated with the festival
    @booking = Booking.new(
      booking_date: params[:booking_date],
      start_time: params[:start_time],
      duration: params[:duration],
      available_slot_id: params[:available_slot_id],
      user: current_user
    )
    @available_slot = AvailableSlot.find(@booking.available_slot_id)
  end


  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    if @booking.save
      @booking.status = 1
      redirect_to user_bookings_path, notice: 'Booking was successfully created.'
    # else
    #   flash.now[:alert] = 'Failed to create booking: '
    #   redirect_to check_availability_festival_path(@booking.available_slot.festival)
    end
  end

  def show
  end

  def destroy
    @booking.destroy
    redirect_to user_bookings_path
  end

  private

  def set_booking
    @booking = current_user.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_time, :duration, :booking_date, :available_slot_id)
  end
end
