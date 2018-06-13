class HomeController < ApplicationController

  def index
    @navbar = false
    # if current_user != nil
    #   if current_user.guide
    #     redirect_to my_tours_path
    #   else
    #     redirect_to tours_path
    #   end
    # end
  end
  def user
    @navbar = false
  end
end

