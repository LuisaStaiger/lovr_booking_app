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
      @start_date = @festival.start_date
      @end_date = @festival.end_date

      @available_slots = calculate_available_slots(@start_date, @end_date)
      create_available_slot_instances(@available_slots)

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
    @festival = Festival.find(params[:id])
    # @date = params[:date]
    # @duration = params[:duration].to_i

    if @date.present? && @duration.present?
      # @available_slots = calculate_available_slots(@date, @duration)
      # create_available_slot_instances(@available_slots)

      @display_slots = AvailableSlot.all
    else
      @available_slots = []
    end

    render :check_availability
  end

  private

  def set_festival
    @festival = Festival.find(params[:id])
  end

  def calculate_available_slots(start_date, end_date)
    durations = [25, 55]
    available_slots = []

    durations.each do |duration|
      (start_date..end_date).each do |date|
        start_time = DateTime.parse("#{date} 09:00")
        end_time = DateTime.parse("#{date} 23:00")

        while start_time + duration.minutes <= end_time
          time_frame = "#{start_time.strftime('%H:%M')} - #{(start_time + duration.minutes).strftime('%H:%M')}"
          available_slots << [date, time_frame, start_time, start_time + duration.minutes, duration]
          start_time += (duration + 5).minutes
        end
        end
      end
      available_slots
  end

  # def calculate_available_slots(date, duration)

  #   begin
  #     start_time = DateTime.parse("#{date} 09:00")
  #     end_time = DateTime.parse("#{date} 23:00")
  #   rescue ArgumentError
  #     flash[:alert] = "Invalid date format."
  #     return []
  #   end

  #   time_slots = []
  #   while start_time + duration.minutes <= end_time
  #     if check_if_slot_available(start_time, duration)
  #       time_slots << "#{start_time.strftime('%H:%M')} - #{(start_time + duration.minutes).strftime('%H:%M')}"
  #     end
  #     start_time += (duration + 5).minutes
  #   end

  #   time_slots
  # end

  # def check_if_slot_available(start_time, duration)
  #   end_time = start_time + duration.minutes
  #   @festival.love_pods.any? do |pod|
  #     pod.is_available_for?(start_time.to_date, start_time, end_time)
  #   end
  # end

  def create_available_slot_instances(available_slots)
    available_slots.each do |slot|
      date = slot[0].to_datetime
      time_frame = slot[1]
      start_time = slot[2]
      duration = slot[4]

      @festival.love_pods.each do |pod|
        AvailableSlot.create(date: date,
        time_frame: time_frame,
        start_time: start_time,
        duration: duration, festival: @festival,
        love_pod: pod)
      end
    end
  end


  # def find_free_pod_for_slot(slot)
  #   available_pod = nil

  #   @festival.love_pods.each do |pod|
  #     if pod.available_slots.empty?
  #       available_pod = pod
  #       break
  #     elsif !slot_booked?(slot, pod)
  #       available_pod = pod unless available_pod
  #     end
  #   end

  #   available_pod
  # end


  # def slot_booked?(slot, pod)
  #   pod.bookings.any? do |booking|
  #     booking.booking_date == @date && booking.start_time.strftime("%H:%M") == slot.split(' - ').first
  #   end
  # end

  def festival_params
    params.require(:festival).permit(:name, :location, :start_date, :end_date, love_pod_ids: [])
  end
end
