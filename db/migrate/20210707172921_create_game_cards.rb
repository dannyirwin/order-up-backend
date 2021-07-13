class CreateGameCards < ActiveRecord::Migration[6.1]
  def change
    create_table :game_cards do |t|
      t.references :game, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true
      t.boolean :on_board, default: :false

      t.timestamps
    end
  end
end
