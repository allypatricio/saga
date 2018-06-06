class DashboardController < ApplicationController

  def index
    @tours = Tour.where(user_id: current_user.id)
    @bookings_filtered = []
    bookings = Booking.all
    bookings.each do |booking|
      if booking.tour.user_id == current_user.id
        @bookings_filtered << booking
      end
    end

  end
end
