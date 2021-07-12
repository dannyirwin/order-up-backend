class AddPrivateToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :is_private, :boolean, default: false
  end
end
