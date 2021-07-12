class User < ApplicationRecord
    belongs_to :game, dependent: :destroy
end
