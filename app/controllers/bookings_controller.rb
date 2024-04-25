class BookingsController < ApplicationController
  before_action :set_festival, only: [:create]
  before_action :set_love_pod, only: [:create]

  def create
    # @booking = Booking.new(booking_params.merge(user_id: current_user.id)) # Adjust for your user authentication setup
    #  @booking = @festival.bookings.build(
      #   start_time: Time.parse(" #{params[:time]}"),
      #   duration: params[:duration].to_i,
      #   user_id: current_user.id,
    # )
    @booking = Booking.new
    @festival = Festival.find(params[:festival_id]) if params[:festival_id]
    @booking.festival = @festival
    @booking.duration = params[:duration]
    @booking.time_frame = params[:time_frame]
    @booking.user = current_user
    @booking.booking_date = params[:booking_date]
    @love_pod = LovePod.find(params[:festival_id])
    @booking.love_pod = @love_pod
    raise
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

  def set_festival
    @festival = Festival.find(params[:festival_id]) if params[:festival_id]
  end

  def set_love_pod
    @love_pod = FestivalLovePod.find(params[:festival_id]) if params[:festival_id]
  end

  def booking_params
    params.require(:booking).permit(:festival_id, :love_pod_id, :time_frame, :duration, :booking_date)
  end
end
