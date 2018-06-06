class DashboardController < ApplicationController

  def index
    @tours = Tour.where(user_id: current_user.id)

  end
end
