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
    # Handles both initial page load and form submission
    @date = params[:date]
    @duration = params[:duration].to_i
    @available_slots = calculate_available_slots(@date, @duration) if params[:date].present? && params[:duration].present?
    render :check_availability
  end

  private

    def set_festival
      @festival = Festival.find(params[:id])
    end

    def calculate_available_slots(date, duration)
      # Example logic to calculate slots
      start_time = DateTime.parse("#{date} 09:00")  # Assuming the festival starts every day at 9 AM
      end_time = DateTime.parse("#{date} 23:00")    # Assuming the festival ends every day at 11 PM
      time_slots = []

      while start_time + duration.minutes <= end_time
        if check_if_slot_available(start_time, duration)
          time_slots << "#{start_time.strftime('%H:%M')} - #{(start_time + duration.minutes).strftime('%H:%M')}"
        end
        start_time += (duration + 5).minutes  # Increment by slot duration plus a break
      end

      time_slots
    end

    def check_if_slot_available(start_time, duration)
      # Placeholder: Implement actual check against bookings
      true  # Always returns true as a placeholder
    end

    def festival_params
      params.require(:festival).permit(:name, :location, :start_date, :end_date, love_pod_ids: [])
    end
end
