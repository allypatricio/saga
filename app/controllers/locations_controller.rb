class LocationsController < ApplicationController


  private

   def location_params
    params.require(:location).permit(:address, :story, :question, :hint, :answer, :position, :photo, :photo_cache)
  end
end
