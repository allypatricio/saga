class ToursController < ApplicationController
  before_action :set_tour, only: [:edit, :show, :update]
  layout "map", only: [:edit, :show]

  def index
    @tours = Tour.all
    @markers = @tours.map do |tour|
      {
        lat: tour.locations.first.latitude,
        lng: tour.locations.first.longitude,
        infoWindow: {
                    content: "Tour: " + tour.title
                    }
      }
    end
    render layout: "map"
  end

  def new
    @tour = Tour.new
  end

  def create
    @tour = Tour.new(tour_params)
    @tour.user = current_user

    respond_to do |format|
      if @tour.save
        format.html { redirect_to edit_tour_path(@tour), notice: 'Tour was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @location = Location.new
    @locations_ordered = @tour.locations.sort_by {|obj| obj.position}

    @markers = @tour.locations.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
      }
    end
  end


  def update
    @tour.update(tour_params)
    @tour.save
    redirect_to dashboard_index_path

  def show
    @tour = Tour.find(params[:id])
    render layout: "map"
  end

  private

  def set_tour
    @tour = Tour.find(params[:id])
  end

  def tour_params
    params.require(:tour).permit(:title, :price, :duration, :description, :photo, :photo_cache)
  end

end
