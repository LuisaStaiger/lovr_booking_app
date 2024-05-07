class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :create, :destroy]
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
    # @booking = Booking.new
    # @booking.available_slot_id = params[:available_slot_id]
    # @booking.duration = params[:duration]
    # @booking.start_time = params[:start_time]
    # @booking.user = current_user
    # @booking.booking_date = params[:booking_date]

    if @booking.save
      redirect_to booking_path(@booking), notice: 'Booking was successfully created.'
    else
      flash.now[:alert] = 'Failed to create booking: '
      redirect_to check_availability_festival_path(@booking.available_slot.festival)
    end
  end

  def show
  end

  def destroy

  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_time, :duration, :booking_date, :available_slot_id)
  end
end
