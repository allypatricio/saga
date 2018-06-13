class PlayController < ApplicationController
  before_action :authenticate_user!
  layout "mobile"

  def index
    @navbar = false
    @bookings = Booking.where(user_id: current_user.id)
  end

  def show
    booking = Booking.find(params[:id])
    tour = Tour.find(booking.tour_id)
    locations = tour.locations
    raise
  end


end
