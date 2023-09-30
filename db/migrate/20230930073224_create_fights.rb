class CreateFights < ActiveRecord::Migration[7.0]
  def change
    create_table :fights do |t|
      t.belongs_to :winner, index: true, foreign_key: { to_table: :persos }, null: false
      t.belongs_to :loser, index: true, foreign_key: { to_table: :persos }, null: false
      t.timestamps
    end
  end
end
