class Game < ApplicationRecord
    has_many :game_cards, dependent: :destroy
    has_many :cards, through: :game_cards

    def deck
        game_cards.map(&:card)
    end

    def board
        used_game_cards.map(&:card)
    end

    def used_game_cards 
        game_cards.filter{|gc| gc.on_board}.sort_by(&:id)
    end

    def fill_board
        if used_game_cards.length < 12 && unused_game_cards.length != 0
            n = 12 - used_game_cards.length
            n.times do
                first_unused_game_card.update({on_board: true})
            end
        end
        # if board.length == 0
        #     12.times do |i|
        #         game_cards[i].update({board_index: i - 1})
        #     end
        # elsif used_game_cards.length == 12
        #     used_game_cards.each do |gc, i|
        #         gc.update({board_index: i})
        #     end
        # elsif board.length < 12
        #     if !(game_cards.length < 12)
        #         used_board_indecies = game_cards.filter{|gc| gc.board_index}.map(&:board_index)
        #         12.times do |i|
        #             if !used_board_indecies.include?(i - 1)
        #                 first_unused_game_card.update({board_index: i - 1})
        #             end
        #         end
        #     end
        # end
    end

    def add_cards
        if used_game_cards.length < 15 && unused_game_cards.length != 0
            3.times do |i|
                first_unused_game_card.update({on_board: true})
            end
        end
    end

    def first_unused_game_card
        game_cards.find{|gc| !gc.on_board}
    end

    def unused_game_cards
        game_cards.filter{|gc| !gc.on_board}
    end

    def remove_cards_from_game cards
        cards.each do |card|
            card = game_cards.find_by(card_id: card[:id])
            if card
                card.destroy
            end
        end
    end

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

    def self.isSet? cards
        card1, card2, card3 = cards
        attributes = ["color","fill","shape","count"]
        attributes.each do |atr|
            if (card1[atr] == card2[atr] and card1[atr] != card3[atr])
                return false
            end
            if (card1[atr] != card2[atr] and card1[atr] == card3[atr])
                return false
            end
            if (card2[atr] == card1[atr] and card2[atr] != card3[atr])
                return false
            end
            if (card2[atr] != card1[atr] and card2[atr] == card3[atr])
                return false
            end
            if (card3[atr] == card1[atr] and card3[atr] != card2[atr])
                return false
            end
            if (card3[atr] != card1[atr] and card3[atr] == card2[atr])
                return false
            end
        end
        true
    end
end
