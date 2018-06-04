class ToursController < ApplicationController
  before_action :set_tour, only: [:edit, :show]
  layout "map", only: [:edit, :show]

  def new
    @tour = Tour.new
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

    @location = Location.new

  end

  def show
  end

  private

  def set_tour
    @tour = Tour.find(params[:id])
  end

  def tour_params
    params.require(:tour).permit(:title, :price, :duration, :description)
  end

end
