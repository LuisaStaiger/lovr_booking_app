class BookingsController < ApplicationController
  before_action :set_festival, only: [:create]
  before_action :set_love_pod, only: [:create]

  def create
    @booking = Booking.new(booking_params.merge(user_id: current_user.id)) # Adjust for your user authentication setup
    if @booking.save
      redirect_to booking_path(@booking), notice: 'Booking was successfully created.'
    else
      flash.now[:alert] = 'Failed to create booking: ' + @booking.errors.full_messages.to_sentence
      redirect_to check_availability_festival_path(@festival)
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

  def set_festival
    @festival = Festival.find(params[:festival_id]) if params[:festival_id]
  end

  def set_love_pod
    @love_pod = LovePod.find(params[:love_pod_id]) if params[:love_pod_id]
  end

  def booking_params
    params.require(:booking).permit(:festival_id, :love_pod_id, :start_time, :duration)
  end
end
