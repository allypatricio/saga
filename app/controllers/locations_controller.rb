class LocationsController < ApplicationController
  before_action :set_tour, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_location, only: [:edit, :update]
  layout "map", only: [:edit]


  def new
  end

  def create
    @location = Location.new(location_params)
    @location.tour = @tour
    if @location.save
      @location_html = render_to_string(partial: 'locations/location', locals: {location: @location})
      @modal_html = render_to_string(partial: 'tours/editLocationModal', locals: {tour: @tour, location: @location})
      respond_to do |format|
        format.js do
          render json: {location: @location_html, modal: @modal_html}
        end
        format.html { redirect_to edit_tour_path(@tour), notice: "Location succesfully added"}
      end
    else
      redirect_to edit_tour_path(@tour), alert: "Adding location failed, please try again"
    end
  end

  def edit
  end

  def update
    if @location.update(location_params)
      respond_to do |format|
        format.js
        # format.html { redirect_to edit_tour_path(@tour), notice: "Location succesfully edited"}
        format.json { render json: @location, status: :ok }
      end
    else
      respond_to do |format|
        format.js
        # format.html { redirect_to edit_tour_path(@tour), alert: "Could not update location, please try again"}
        format.json { render json: {errors: @location.errors.messages }, status: :unprocessable_entity }
      end
    end
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
    params.require(:location).permit(:address, :position, :story, :question, :hint, :answer, :photo, :photo_cache)
  end
end
