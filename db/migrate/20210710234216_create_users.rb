class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.references :game, null: false, foreign_key: true
      t.integer :points, default: 0

      t.timestamps
    end
  end
end
