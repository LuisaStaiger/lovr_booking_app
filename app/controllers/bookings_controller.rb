class BookingsController < ApplicationController
  before_action :set_festival
  before_action :set_love_pod
  before_action :set_booking, only: [:show, :destroy]

  def new
    @booking = @love_pod.bookings.new
    # Additional setup for the form, if necessary
  end

  def create
    @booking = @love_pod.bookings.new(booking_params)
    @booking.user = current_user # Assuming Devise for user authentication

    if @booking.save
      redirect_to [@festival, @love_pod, @booking], notice: 'Booking was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = @love_pod.bookings.find(params[:id])
  end

  def destroy
    @booking.destroy
    redirect_to festival_love_pod_path(@festival, @love_pod), notice: 'Booking was successfully canceled.'
  end

  def search_available_pods
    booking_date = params[:booking_date]
    start_time = params[:start_time]
    duration = params[:duration].to_i
    number_of_people = params[:number_of_people].to_i

    @available_love_pods = @festival.love_pods.select do |pod|
      pod.is_available_for?(booking_date, start_time, duration, number_of_people)
    end

    if @available_love_pods.empty?
      redirect_to festival_path(@festival), alert: 'No available LovePods for the specified time and capacity.'
    else
      # This should redirect to a view that lets the user pick from available LovePods
      render :select_love_pod # Make sure this view is created
    end
  end


  private

  def booking_params
    params.require(:booking).permit(:booking_date, :number_of_people, :start_time, :duration)
  end

  def set_festival
    @festival = Festival.find(params[:festival_id])
  end

  def set_love_pod
    @love_pod = @festival.love_pods.find(params[:love_pod_id])
  end

  def set_booking
    @booking = @love_pod.bookings.find(params[:id])
  end

end
