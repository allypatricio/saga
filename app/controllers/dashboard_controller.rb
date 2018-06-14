class DashboardController < ApplicationController

  def my_tours
    if !current_user.guide
      flash[:alert]= "You are not a tour guide!"
      redirect_to tours_path
    end
    @tour = Tour.new
    @tours = Tour.where(user_id: current_user.id)
    @bookings_filtered = []
    bookings = Booking.all
    bookings.each do |booking|
      if booking.tour.user_id == current_user.id
        @bookings_filtered << booking
      end
    end
    @bookings_guest = Booking.where(user_id: current_user.id)
  end

  def my_bookings
    @tours = Tour.where(user_id: current_user.id)
    @bookings_filtered = []
    bookings = Booking.all
    bookings.each do |booking|
      raise
      if booking.tour.user_id == current_user.id
        @bookings_filtered << booking
      end
    end
    @bookings_guest = Booking.where(user_id: current_user.id)
  end
end
