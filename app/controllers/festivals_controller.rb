class FestivalsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index], if: -> { action_name == 'index' && controller_name == 'festivals' }
  before_action :set_festival, only: [:show, :edit, :update, :destroy, :check_availability]

  # GET /festivals
  def index
    @festivals = Festival.all
  end

  # GET /festivals/1
  def show
  end

  # GET /festivals/new
  def new
    @festival = Festival.new
  end

  # GET /festivals/1/edit
  def edit
  end

  # POST /festivals
  def create
    @festival = Festival.new(festival_params)
    if @festival.save
      redirect_to @festival, notice: 'Festival was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /festivals/1
  def update
    if @festival.update(festival_params)
      redirect_to @festival, notice: 'Festival was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /festivals/1
  def destroy
    @festival.destroy
    redirect_to festivals_path, notice: 'Festival was successfully deleted.'
  end

  # GET /festivals/1/check_availability
  def check_availability
    # @festival = Festival.find(params:[id])
    @date = params[:date]
    @duration = params[:duration].to_i
    @available_slots = calculate_available_slots(@date, @duration)
    render :check_availability
  end

  def check_availability
    @festival = Festival.find(params[:id])
    @date = params[:date]
    @duration = params[:duration].to_i
    if @date.present? && @duration.present?
      @available_slots = calculate_available_slots(@date, @duration)
    else
      @available_slots = []
    end

    render :check_availability
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
    @festival = Festival.find(params[:id])
  end

  def calculate_available_slots(date, duration)
    begin
      start_time = DateTime.parse("#{date} 09:00")
      end_time = DateTime.parse("#{date} 23:00")
    rescue ArgumentError
      flash[:alert] = "Invalid date format."
      return []
    end

    time_slots = []
    while start_time + duration.minutes <= end_time
      if check_if_slot_available(start_time, duration)
        time_slots << "#{start_time.strftime('%H:%M')} - #{(start_time + duration.minutes).strftime('%H:%M')}"
      end
      start_time += (duration + 5).minutes
    end

    time_slots
  end

  def check_if_slot_available(start_time, duration)
    end_time = start_time + duration.minutes
    @festival.love_pods.any? do |pod|
      pod.is_available_for?(start_time.to_date, start_time, end_time)
    end
  end


  def festival_params
    params.require(:festival).permit(:name, :location, :start_date, :end_date, love_pod_ids: [])
  end
end

# just to push
