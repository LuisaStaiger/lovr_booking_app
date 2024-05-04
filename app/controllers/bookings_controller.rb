class BookingsController < ApplicationController
  # before_action :set_festival, only: [:create]
  # before_action :set_love_pod, only: [:create]

  def create
    # @booking = Booking.new(booking_params.merge(user_id: current_user.id)) # Adjust for your user authentication setup
    #  @booking = @festival.bookings.build(
      #   start_time: Time.parse(" #{params[:time]}"),
      #   duration: params[:duration].to_i,
      #   user_id: current_user.id,
    # )
    @booking = Booking.new
    @booking.available_slot_id = params[:available_slot_id]
    @booking.duration = params[:duration]
    @booking.start_time = params[:start_time]
    @booking.user = current_user
    @booking.booking_date = params[:booking_date]

    if @booking.save
      redirect_to booking_path(@booking), notice: 'Booking was successfully created.'
    else
      flash.now[:alert] = 'Failed to create booking: '
      redirect_to check_availability_festival_path(@booking.available_slot.festival)
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  # # POST /festivals/1/confirm_booking
  # def confirm_booking
  #   @booking = @festival.bookings.build(
  #     start_time: DateTime.parse("#{params[:date]} #{params[:time]}"),
  #     duration: params[:duration].to_i,
  #     user_id: current_user.id
  #   )

  #   if @booking.save
  #     redirect_to booking_path(@booking), notice: 'Booking was successfully created.'
  #   else
  #     flash[:alert] = 'Failed to create booking.'
  #     render :check_availability
  #   end
  # end

  private

  # def set_festival
  #   @festival = Festival.find(params[:festival_id]) if params[:festival_id]
  # end

  # def set_love_pod
  #   @love_pod = FestivalLovePod.find(params[:festival_id]) if params[:festival_id]
  # end

  def booking_params
    params.require(:booking).permit(:start_time, :duration, :booking_date, :available_slot_id)
  end
end
