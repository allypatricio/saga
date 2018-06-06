class BookingsController < ApplicationController

  before_action :set_tour, only: :create


  def index
    @no_container = true
    @tours = Tour.all
    bookings = Booking.all
    @bookings_user = []
    bookings.each do |booking|
     if booking.user_id  == current_user.id
      @bookings_user << booking
    end
  end

  @bookings_host = []
  bookings.each do |booking|
    if Tour.find(booking.tour_id).user_id == current_user.id
      @bookings_host << booking
    end
  end
end


def new
  @tour = Tour.find(params[:tour_id])
  @booking = Booking.new(user_id: current_user.id, tour_id: @tour.id)
end

def create
  @booking = Booking.new(booking_params)
  @booking.tour = @tour
  @booking.user = current_user
  respond_to do |format|
    if @booking.save
      format.html { redirect_to @tour, notice: 'Your booking is confirmed!' }
    elsif !user_signed_in?
      format.html { redirect_to new_user_session_path, notice: 'Please sign in to make a booking' }
    else
      format.html { render :new }
    end
  end
end
def destroy
  @booking = Booking.find(params[:id])
  @booking.destroy
end

private

def set_tour
  @tour = Tour.find(params[:tour_id])
end

def booking_params
  params.permit(:tour_id)
end
end
