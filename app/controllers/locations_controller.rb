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
      respond_to do |format|
        format.js do
          # byebug
          render json: {location: @location_html}
        end
        format.html { redirect_to edit_tour_path(@tour), notice: "Location succesfully added"}
      end
    else
      redirect_to edit_tour_path(@tour), notice: "Adding location failed, please try again"
    end
    # respond_to do |format|
    #     format.js do
    #       byebug
    #     end
    #   end
  end

  def edit
  end

  def update
    if @location.update(location_params)
      respond_to do |format|
        format.html { redirect_to edit_tour_path(@tour), notice: "Location succesfully edited"}
        format.json { render json: @location, status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to edit_tour_path(@tour), alert: "Could not update location, please try again"}
        render json: {errors: @location.errors.messages }, status: :unprocessable_entity
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
