class GamesController < ApplicationController
    before_action :find_game, only: [:show, :update, :destroy]
    def index
        games = Game.all.map{|game| game.game_data}
        render json: games
    end

    def create
        game = Game.new key: Game.generate_key
        game.generate_deck
        game.fill_board
        if game.save
            render json: game
        else
            render json: game.errors.full_messages
        end
    end

    def update
            case params[:method]
            when "check_set"
                cards = params[:cards]
                if Game.isSet? cards
                    @game.remove_cards_from_game(cards)
                    @game.fill_board
                    @game.board                
                    @game.broadcastGame
                    render json: {message: "Cards Removed", board: @game.board}
                else 
                    render json: {message: "Not a valid Order."}
                end
            when "add_cards"
                @game.add_cards
                @game.broadcastGame
                render json:{message: "Cards Added",board: @game.board}
            when "start_game"
                @game.update({state: "Game in progress"})
                @game.broadcastGame
            else
                render json: {message: "Invalid Method: " + params[:method]}
            end   
    end

    def show
        @game.fill_board
        @game.check_for_game_over
        render json: @game.game_data
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
