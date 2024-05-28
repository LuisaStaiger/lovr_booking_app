class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :destroy]

  def new
    @festival = Festival.find(params[:festival_id])
    @booking = Booking.new(
      booking_date: params[:booking_date],
      start_time: params[:start_time],
      duration: params[:duration],
      available_slot_id: params[:available_slot_id],
      user: current_user,
      slots_sku: params[:slots_sku],
      amount: params[:amount]
    )
    @available_slot = AvailableSlot.find(params[:available_slot_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    #@booking.status = :pending
    if @booking.save
      slot = AvailableSlot.find(params[:booking][:available_slot_id])
      @festival = slot.festival
      festival = @festival
      @love_pod = slot.love_pod

      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          price_data: {
            currency: 'eur',
            product_data: {
              name: slot.id.to_s,
            },
            unit_amount: slot.price_cents,
          },
          quantity: 1,
        }],
        mode: 'payment',
        success_url: user_bookings_url,
        cancel_url: check_availability_festival_url(festival)
      )

      puts "Stripe Checkout Session: #{session.inspect}"

      @booking.update(checkout_session_id: session.id, status: 1)
      redirect_to session.url, allow_other_host: true
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

  private

  def set_booking
    @booking = current_user.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_time, :duration, :booking_date, :amount, :available_slot_id)
  end

end
