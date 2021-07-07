class GamesController < ApplicationController
    before_action :find_game, only: [:show, :update, :destroy]
    def index
        games = Game.all
        render json: games
    end

    def create
        game = Game.new key: Game.generate_key
        game.generate_deck
        game.fill_board
        if game.save
            # ActionCable.server.broadcast 'games_channel', game
            render json: game, include: [:board]
        else
            render json: game.errors.full_messages
        end
    end

    def update
        cards = params[:cards]
        if Game.isSet? cards[0], cards[1], cards[2]
            
            render json: @game
        else 
            render json: {message: "nope"}
        end
        
        # ActionCable.server.broadcast 'games_channel', game
    end

    def show
        render json: @game, methods: [:board]
    end

    def destroy
        @game.destroy
        render json: {message: "Game destroyed"}
    end

    private

    def find_game
        @game = Game.find(params[:id])
    end

end
