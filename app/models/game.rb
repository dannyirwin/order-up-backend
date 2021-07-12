class Game < ApplicationRecord
    has_many :game_cards, dependent: :destroy
    has_many :cards, through: :game_cards

    has_many :users, dependent: :destroy
    def board
        used_game_cards.map(&:card)
    end

    def used_game_cards 
        game_cards.filter{|gc| gc.on_board}.sort_by(&:id)
    end

    def fill_board
        if used_game_cards.length < 12 && deck.length != 0
            n = 12 - used_game_cards.length
            n.times do
                first_in_deck.update({on_board: true})
            end
        end
    end

    def broadcastGame
        check_for_game_over
            GamesChannel.broadcast_to self, self.game_data
    end

    def game_data
        {
            id: self.id,
            board: self.board,
            key: self.key,
            state: self.state,
            deckLength: deck.length,
            users: users

        }
        end

    def add_cards
        if used_game_cards.length < 15 && deck.length != 0
            3.times do |i|
                first_in_deck.update({on_board: true})
            end
        end
    end

    def first_in_deck
        game_cards.find{|gc| !gc.on_board}
    end

    def deck
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

    def boardContainsSet
        (0...board.length).each{|i|
            card1 = board[i]
            ((i+1)...board.length).each{|j|
                card2 = board[j]
                ((j+1)...board.length).each{|k|
                    card3 = board[k]
                    if Game.isSet? [card1, card2, card3]
                        return true
                    end
                }
            }
        }
        return false;
    end

    def check_for_game_over
        if deck.length == 0 && !boardContainsSet
            self.update({state: "Game Over"})
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
