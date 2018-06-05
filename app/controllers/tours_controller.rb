class ToursController < ApplicationController

  def index
    @tours = Tour.all
    @markers = @tours.map do |tour|
      {
        lat: tour.locations.first.latitude,
        lng: tour.locations.first.longitude
      }
    end
    render layout: "map"
  end

  def new
    @tour = Tour.new()
    # tour.user = current_user
  end

  def create
    @tour = Tour.new(tour_params)
    @tour.user = current_user

    respond_to do |format|
      if @tour.save
        format.html { redirect_to @tour, notice: 'Tour was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    render layout: "map"
  end

  def show
    @tour = Tour.find(params[:id])
    render layout: "map"
  end

  private

  def tour_params
    params.require(:tour).permit(:title, :price, :duration, :description, :photo, :photo_cache)
  end

end
