class GamesController < ApplicationController
    def index
        games = Game.all
        render json: games
    end

    def create
        game = Game.new(game_params)
        if game.save
            ActionCable.server.broadcast 'games_channel', game
            head :ok
        else
            head :ok
        end
    end


    def update
        game = Game.all.find(params[:id])
        game.update!(game_params)
        ActionCable.server.broadcast 'games_channel', game
        render json: game
    end

    def show
        render json: Game.all.find(params[:id])
    end

    private
    def game_params
        params.require(:game).permit(:deck, :cardsToShow)
    end
end
