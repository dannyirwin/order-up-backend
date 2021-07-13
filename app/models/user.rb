class User < ApplicationRecord
    belongs_to :game, dependent: :destroy

    def add_point
        self.update({points: self.points + 1})
    end

    def reset_points
        self.update({points: 0})
    end
end
