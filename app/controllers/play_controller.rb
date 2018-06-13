class PlayController < ApplicationController
  layout 'mobile'

  def index
  end

  def first
  end

  def second
    answer = params[:answer];
    if answer != "blue"
      flash[:error]= "The answer is not correct"
      redirect_to play_1_path
    end
  end

  def third
    answer = params[:answer];
    if answer != "green"
      flash[:error]= "The answer is not correct"
      redirect_to "/play/2?answer=blue"
    end
  end

  def final
    answer = params[:answer];
    if answer != "pink"
      flash[:error]= "The answer is not correct"
      redirect_to "/play/3?answer=green"
    end
  end


end
