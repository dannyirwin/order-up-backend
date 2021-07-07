class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      # t.string :deck
      # t.string :board
      t.string :key
      # t.integer :cards_to_show

      t.timestamps
    end
  end
end
