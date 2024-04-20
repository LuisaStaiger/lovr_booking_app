class BookingsController < ApplicationController
  before_action :set_festival, only: [:new, :create, :search_available_pods]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params.merge(festival_id: @festival.id))
    @booking.user = current_user # Assuming Devise for user authentication

    if @booking.save
      redirect_to @booking, notice: 'Booking was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def search_available_pods
    booking_date = params[:booking_date]
    start_time = Time.parse(params[:start_time])
    duration = params[:duration].to_i
    number_of_people = params[:number_of_people].to_i

    # Filtering available love pods at the festival level
    @available_love_pods = @festival.love_pods.select do |pod|
      pod.is_available_for?(booking_date, start_time, start_time + duration.minutes, number_of_people)
    end

    if @available_love_pods.empty?
      redirect_to festival_path(@festival), alert: 'No available LovePods for the specified time and capacity.'
    else
      # Assuming you have a view to show the list of available love pods
      render :select_love_pod
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :love_pod_id, :start_time, :duration, :number_of_people)
  end

  def set_festival
    @festival = Festival.find(params[:festival_id])
  end
end
