class LocationsController < ApplicationController
  before_action :set_tour, only: [:new, :create, :edit, :update]
  before_action :set_location, only: [:edit, :update]

  def new
    @location = Location.new
    @location.tour = @tour
  end

  def create
    @location = Location.new(location_params)
    @location.tour = @tour
    @location.title = "Click to add details"
    @location.position = @tour.locations.count + 1
    @location.save
  end

  def edit
  end

  def update
    @location.update(location_params)
    redirect_to edit_tour_path(@tour)
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def set_tour
    @tour = Tour.find(params[:tour_id])
  end

  def location_params
    params.require(:location).permit(:title, :address, :position, :story, :question, :hint, :answer)
  end
end
