class GamesChannel < ApplicationCable::Channel
  def subscribed
        stream_for game
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def game
    Game.find(params[:game_id])
  end
end
