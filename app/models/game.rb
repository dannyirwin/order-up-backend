class Game < ApplicationRecord
    has_many :game_cards, dependent: :destroy
    has_many :cards, through: :game_cards

    def deck
        game_cards.map(&:card)
    end

    def board
        game_cards.filter{|gc| gc.board_index}.map(&:card)
    end

    def fill_board
        12.times do |i|
            game_card = game_cards[i]
            game_card.update({board_index: i})
        end
    end

    # def update_board
    #     unused_cards = game_cards.filter{|gc| !gc.board_index}
    #     if board.length < 12
    #         for i in 1..12
    #             # if !board[i].board_index
    #             #     unused_cards.first.board_index = i
    #             # end
    #         end
    #     end
    # end

    def generate_deck
        all_cards = Card.all
        all_cards.shuffle.each do |card|
            GameCard.create card: card, game: self
        end
    end

    def self.generate_key
        charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
        key = Array.new(4) { charset.sample }.join
        if Game.find_by(key: key)
            key = generateKey
        end
        key
    end

    def self.isSet? card1, card2, card3
        attributes = card1.keys
        attributes.each do |atr|
            if card1[atr] == card2[atr] and card1[atr] != card3[atr]
                return false
            end
            if card1[atr] != card2[atr] and card1[atr] == card3[atr]
                return false
            end
            if card2[atr] == card1[atr] and card2[atr] != card3[atr]
                return false
            end
            if card2[atr] != card1[atr] and card2[atr] == card3[atr]
                return false
            end
            if card3[atr] == card1[atr] and card3[atr] != card2[atr]
                return false
            end
            if card3[atr] != card1[atr] and card3[atr] == card2[atr]
                return false
            end
        end
        return true
    end
end
