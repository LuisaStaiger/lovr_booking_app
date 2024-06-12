class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :destroy, :checkout]

  def index
    @bookings = Booking.all
    @confirmed_bookings = @bookings.where(status: 1)
    @pending_bookings = @bookings.where(status: 0)
  end

  def new
    @festival = Festival.find(params[:festival_id])
    @booking = Booking.new(
      booking_date: params[:booking_date],
      start_time: params[:start_time],
      duration: params[:duration],
      available_slot_id: params[:available_slot_id],
      user: current_user,
      slots_sku: params[:slots_sku],
      amount: params[:amount],
    )
    @available_slot = AvailableSlot.find(params[:available_slot_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    if @booking.save
      checkout
    else
      flash.now[:alert] = 'Failed to create booking.'
      redirect_to new_festival_booking_path(@festival, @booking)
    end
  end

  def show
  end

  def destroy
    @booking.destroy
    redirect_to user_bookings_path
  end

  def checkout
    create_session
  end

  private
  def set_booking
    @booking = current_user.bookings.find(params[:id])
  end

  def create_session
    booking = @booking
    slot = AvailableSlot.find(@booking.available_slot_id)
    @festival = slot.festival
    festival = @festival
    @love_pod = slot.love_pod

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'eur',
          product_data: {
            name: "#{booking.booking_date.strftime('%a %d %b %Y')} - #{booking.start_time.strftime('%I:%M:%S %p')}",
            description: "#{booking.duration} minutes in #{booking.available_slot.love_pod.name}",
          },
          unit_amount: booking.amount_cents,
        },
        quantity: 1,
        }],
        metadata: {
          expires_at: (Time.now.to_i + 1800)},
          mode: 'payment',
          success_url: user_bookings_url,
          cancel_url: check_availability_festival_url(festival,
          booking_date: booking.booking_date.to_s, duration: booking.duration)
          )

    @booking.update(checkout_session_id: session.id)
    redirect_to session.url, allow_other_host: true
  end

  def booking_params
    params.require(:booking).permit(:start_time, :duration, :booking_date, :amount, :available_slot_id)
  end
end
