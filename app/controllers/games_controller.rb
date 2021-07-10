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
            render json: game
            # GamesChannel.broadcast_to game, game
        else
            render json: game.errors.full_messages
        end
    end

    def update
        if params[:cards]
            cards = params[:cards]
            if Game.isSet? cards
                @game.remove_cards_from_game(cards)
                @game.fill_board
                @game.board                
                GamesChannel.broadcast_to @game, {
                    id: @game.id,
                    board: @game.board,
                    key: @game.key
                }
                render json: {message: "Cards Removed", board: @game.board}
            else 
                render json: {message: "Not a valid Order."}
            end
        elsif params[:method]
            case params[:method]
            when "add_cards"
                @game.add_cards
                GamesChannel.broadcast_to @game, {
                    id: @game.id,
                    board: @game.board,
                    key: @game.key
                }
                render json:{message: "Cards Added",board: @game.board}
            else
                render json: {message: params}
            end   
        end
    end

    def show
        @game.fill_board
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
