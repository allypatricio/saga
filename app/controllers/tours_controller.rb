class ToursController < ApplicationController
  before_action :set_tour, only: [:edit, :show, :update, :change_status]
  layout "map", only: [:edit, :show]

  def index
    @tours = Tour.active

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
        icon: {url: 'https://raw.githubusercontent.com/Concept211/Google-Maps-Markers/master/images/marker_red.png'},
        lat: tour.locations.first.latitude,
        lng: tour.locations.first.longitude,
        infoWindow: {
                    content: render_to_string(partial: "/shared/info_window", locals: { tour: tour})
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
        format.html { redirect_to edit_tour_path(Tour.last), notice: 'Tour was successfully created.' }
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
        icon: {url: "https://raw.githubusercontent.com/Concept211/Google-Maps-Markers/master/images/marker_red.png"},
        lat: location.latitude,
        lng: location.longitude,
        infoWindow: {
                    content: render_to_string(partial: "/tours/editInfoWindow", locals: { location: location})
                    }
      }
    end
  end

  def update
    @tour.update(tour_params)
    respond_to do |format|
      if @tour.save
        format.html { redirect_to my_tours_path, notice: 'Your tour is submitted for review' }
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
    @reviews_full = Review.where(tour_id: @tour.id)
    @reviews = Review.where(tour_id: @tour.id).last(5)
    ratings = []
    @reviews_full.each do |review|
      ratings << review.rating
    end
    if ratings.any?
      @average_rating = ratings.sum / ratings.size
    else
      @average_rating = 0
    end

    @booking = Booking.new(tour_id: params[:id])
  end

  def change_status
    if @tour.active?
      @tour.disactivate
    else
      @tour.activate
    end

  end

  private

  def set_tour
    @tour = Tour.find(params[:id])
  end

  def tour_params
    params.require(:tour).permit(:title, :category, :price, :duration, :description, :location, :photo, :status)
  end

end
