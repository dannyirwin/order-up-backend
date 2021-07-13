class MessagesController < ApplicationController

    def create
        message = Message.new message_params
        if message.save
            message.game.broadcastGame
        else
            render json: {messages: message.errors.messages}
        end

    end

    private
    def message_params
        params.require(:message).permit(:content, :game_id, :user_id)
    end
end
