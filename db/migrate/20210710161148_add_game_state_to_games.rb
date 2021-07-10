class AddGameStateToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :state, :string, default: "Waiting for Players"
  end
end
