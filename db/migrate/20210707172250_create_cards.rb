class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.integer :color
      t.integer :fill
      t.integer :shape
      t.integer :count

      t.timestamps
    end
  end
end
