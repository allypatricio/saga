class ToursController < ApplicationController
  before_action :set_tour, only: [:edit, :show, :update]
  layout "map", only: [:edit, :show]

  def index
    @tours = Tour.all

    durations = []
    @tours.each do |exp|
      durations << exp.duration
    end

    @max_duration = durations.max.to_i + 1

    prices = []
    @tours.each do |exp|
      prices << exp.price
    end

    @max_price = prices.max.to_i + 10


    @tours = @tours.category(params[:category].downcase.capitalize) if params[:category].present? && !params[:category].empty?



    @markers = @tours.map do |tour|
      {
        lat: tour.locations.first.latitude,
        lng: tour.locations.first.longitude,
        infoWindow: {
                    content: "Tour: " + tour.title
                    }
      }
    end

    respond_to do |format|
      format.html {render layout: "map"}
      format.js
    end

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
  end

  def show
    @tour = Tour.find(params[:id])
    @markers = @tour.locations.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
      }
    end
  end

  private

  def set_tour
    @tour = Tour.find(params[:id])
  end

  def tour_params
    params.require(:tour).permit(:title, :price, :duration, :description, :photo, :photo_cache)
  end

end
