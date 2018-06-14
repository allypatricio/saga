class HomeController < ApplicationController

  def index
    @navbar = false
    if current_user != nil
       if !current_user.guide
         redirect_to user_landing_page_path
       end
     end
  end

  def user
    @navbar = false
    if current_user != nil
     if current_user.guide
         redirect_to root_path
      end
    end

  end
end

