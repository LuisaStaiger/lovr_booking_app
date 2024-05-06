class FestivalsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index], if: -> { action_name == 'index' && controller_name == 'festivals' }
  before_action :set_festival, only: [:show, :edit, :update, :destroy, :check_availability, :calculate_slots]
  before_action :set_available_slots, only: [:check_availability, :update]

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
      @available_slots = calculate_slots
      create_available_slot_instances(@available_slots)
      redirect_to @festival, notice: 'Festival was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /festivals/1
  def update
    if @festival.update(festival_params)
      update_available_slots(@festival)
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
    @date = params[:date]
    @duration = params[:duration].to_i
    if @date.present? && @duration.present?
      @festival_slots
    else
      @festival_slots = []
    end
    render :check_availability
  end

  def calculate_slots
    calculate_available_slots(@festival)
  end

  private

  def set_festival
    @festival = Festival.find(params[:id])
  end

  def set_available_slots
    @festival_slots = AvailableSlot.all.select do |slot|
      slot.festival = @festival
    end
  end

  def calculate_available_slots(festival)
    durations = [25, 55]
    available_slots = []
    start_date = festival.start_date
    end_date = festival.start_date

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

  def update_available_slots(festival)
    old_slots = AvailableSlot.all.select do |slot|
      slot.festival = festival
    end
    new_available_slots = calculate_available_slots(festival)
    updated_slots = []

    new_available_slots.each do |slot|
      festival.love_pods.each do |pod|
        updated_slots << AvailableSlot.new(date: slot[0].to_datetime,
        time_frame: slot[1],
        start_time: slot[2],
        duration: slot[4], festival: festival,
        love_pod: pod)
      end
    end

    updated_slots.each do |new_slot|
      matching_old_slot = old_slots.find do |old_slot|
        old_slot.date == new_slot.date &&
          old_slot.time_frame == new_slot.time_frame &&
          old_slot.start_time == new_slot.start_time &&
          old_slot.duration == new_slot.duration &&
          old_slot.love_pod_id == new_slot.love_pod_id
      end

      if matching_old_slot
        matching_old_slot.attributes = new_slot.attributes
      else
        new_slot.save
      end
    end

    old_slots.each do |old_slot|
      unless updated_slots.any? { |new_slot| new_slot.attributes == old_slot.attributes }
        old_slot.destroy
      end
    end
  end


  def create_available_slot_instances(available_slots)
      available_slots.each do |slot|
        date = slot[0].to_datetime
        time_frame = slot[1]
        start_time = slot[2]
        duration = slot[4]

        @festival.love_pods.each do |pod|
          AvailableSlot.find_or_create_by(date: date,
          time_frame: time_frame,
          start_time: start_time,
          duration: duration, festival: @festival,
          love_pod: pod)
        end
      end
  end

  def festival_params
    params.require(:festival).permit(:name, :location, :start_date, :end_date, love_pod_ids: [], available_slot_ids: [])
  end

  def available_slot_params
    params.require(:available_slot).permit(:date, :time_frame, :start_time, :duration, :festival_id, :love_pod_id)
  end
end
