class FestivalsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index], if: -> { action_name == 'index' && controller_name == 'festivals' }
  skip_before_action :authenticate_user!, only: [:index, :show, :check_availability]
  before_action :set_festival, only: [:edit, :update, :destroy, :show, :check_availability]
  before_action :set_available_slots, only: [:check_availability, :update]

  def index
    @festivals = Festival.all
  end

  def show
  end

  def new
    @festival = Festival.new
  end

  def edit
  end

  def create
    @festival = Festival.new(festival_params)
    if @festival.save
      slots = create_available_slot_instances(@festival)
      slots.each { |slot| slot.save }
      redirect_to @festival, notice: 'Festival was successfully created.'
    else
      render :new
    end
  end

  def update
    if @festival.update(festival_params)
      update_available_slots(@festival)
      redirect_to @festival, notice: 'Festival was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @festival.destroy
    redirect_to festivals_path, notice: 'Festival was successfully deleted.'
  end

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

  private

  def set_festival
    @festival = Festival.find(params[:id])
  end

  def set_available_slots
    @festival_slots = AvailableSlot.all.select do |slot|
      slot.festival = @festival
    end
  end

  def update_available_slots(festival)
    old_slots = AvailableSlot.all.select do |slot|
      slot.festival = festival
    end
    updated_slots = create_available_slot_instances(festival)

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


  def create_available_slot_instances(festival)
    start_date = festival.start_date
    end_date = festival.end_date
    durations = [25, 55]
    slots = []

    durations.each do |duration|
      (start_date..end_date).each do |date|
        festival.love_pods.each do |pod|

        start_time = pod.availabilty_start_time
        end_time = pod.availabilty_end_time

          while start_time + duration.minutes <= end_time
            time_frame = "#{start_time.strftime('%H:%M')} - #{(start_time + duration.minutes).strftime('%H:%M')}"

            slots << AvailableSlot.new(date: date,
            time_frame: time_frame,
            start_time: start_time,
            duration: duration, festival: festival,
            love_pod: pod,
            price: 10)

            start_time += (duration + 5).minutes
          end
        end
      end
    end
    slots
  end

  def festival_params
    params.require(:festival).permit(:name, :location, :start_date, :end_date, love_pod_ids: [], available_slot_ids: [])
  end

  def available_slot_params
    params.require(:available_slot).permit(:date, :time_frame, :start_time, :duration, :festival_id, :love_pod_id)
  end
end
