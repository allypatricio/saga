class LocationsController < ApplicationController
  before_action :set_tour, only: [:new, :create]

  def new
    @location = Location.new
    @location.tour = @tour
  end

  def create
    @location = Location.new(location_params)
    @location.tour = @tour
    @location.save
  end

  private

  def set_tour
    @tour = Tour.find(params[:tour_id])
  end

  def location_params
    params.require(:location).permit(:address)
  end
end
