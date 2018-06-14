class PlayController < ApplicationController
  layout 'mobile'

  def index
    session[:name] = nil
    session[:player_id] = nil
  end

  def first
    if session[:name] != nil
      name = session[:name]
    else
      name = params[:name]
      if Player.find_by(name: name)
        flash[:error]= "Name already taken"
        redirect_to play_path
      end
    end

    session[:name] = name
    player = Player.create(name: name, start_time: Time.now)
    session[:player_id] = player.id
  end

  def second
    answer = params[:answer].downcase;
    if answer != "welcome!"
      flash[:error]= "The answer is not correct"
      redirect_to play_1_path
    end
  end

  def third
    answer = params[:answer].downcase;
    if answer != "benfica"
      flash[:error]= "The answer is not correct"
      redirect_to "/play/2?answer=welcome!"
    end
  end

  def final
    answer = params[:answer].downcase;
    if answer != "texas"
      flash[:error]= "The answer is not correct"
      redirect_to "/play/3?answer=benfica"
    end

    player = Player.find(session['player_id'])
    player.end_time = Time.now
    player.save
    @time = player.end_time - player.start_time
  end

  def scoreboard
    @players = Player.all.order('end_time - start_time')
  end


end
