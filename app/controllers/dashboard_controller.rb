class DashboardController < ApplicationController

  def my_tours
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
      if booking.tour.user_id == current_user.id
        @bookings_filtered << booking
      end
    end
    @bookings_guest = Booking.where(user_id: current_user.id)
  end
end
