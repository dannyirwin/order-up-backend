class UsersController < ApplicationController

    def index
        users = User.all 
        render json: users
    end

    def create
        user = User.new user_params
        if user.save
            user.game.broadcastGame
            render json: user
        else  
            render json: {messages: user.errors.full_messages}
        end
    end

    def update
        
    end

    private
    def user_params
        params.require(:user).permit(:username, :game_id, :color, :icon_id)
    end

end
