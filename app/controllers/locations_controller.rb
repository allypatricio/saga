class LocationsController < ApplicationController
  before_action :set_tour, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_location, only: [:edit, :update]
  layout "map", only: [:edit]


  def new
  end

  def create
    @location = Location.new(location_params)
    @location.tour = @tour
    @location.position = @tour.locations.count + 1
    if @location.save && @location.longitude != 0
      redirect_to edit_tour_path(@tour)
    elsif @location.save
      redirect_to edit_tour_path(@tour)
      # add notice
    else
      redirect_to edit_tour_path(@tour)
      # add notice
    end

  end

  def edit
  end

  def update
    @location.update(location_params)
    redirect_to edit_tour_path(@tour)
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
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
