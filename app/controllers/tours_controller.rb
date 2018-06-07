class ToursController < ApplicationController
  before_action :set_tour, only: [:edit, :show, :update, :create]
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


    @tours = @tours.location(params[:location]) if params[:location].present?
    @tours = @tours.category(params[:category].downcase.capitalize) if params[:category].present? && !params[:category].empty?
    @tours = @tours.duration(params[:duration]) if params[:duration].present?
    @tours = @tours.price(params[:price]) if params[:price].present?




    @markers = @tours.map do |tour|
      {
        icon: {url: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png'},
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

    @markers = @locations_ordered.map do |location|
      {
        icon: {url: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png'},
        lat: location.latitude,
        lng: location.longitude,
        infoWindow: {
                    content: location.position.to_s + ": " + location.address
                    }
      }
    end
  end


  def update
    @tour.update(tour_params)
    respond_to do |format|
      if @tour.save
        format.html { redirect_to dashboard_index_path, notice: 'Your tour is submitted for review' }
        format.js
      else
        format.html { redirect_to edit_tour_path }
        format.js
      end
    end
  end

  def show
    @tour = Tour.find(params[:id])
    @markers = @tour.locations.map do |location|
      {
        lat: @tour.locations.first.latitude,
        lng: @tour.locations.first.longitude,
      }
    end
@booking = Booking.new(tour_id: params[:id])
  end



  private

  def set_tour
    @tour = Tour.find(params[:id])
  end

  def tour_params
    params.require(:tour).permit(:title, :price, :duration, :description, :photo, :photo_cache, :location)
  end

end
