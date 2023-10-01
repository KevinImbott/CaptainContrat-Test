class CreateBattles < ActiveRecord::Migration[7.0]
  def change
    create_table :battles do |t|
      t.belongs_to :champion, index: true, foreign_key: { to_table: :champions }, null: false
      t.belongs_to :opponent, index: true, foreign_key: { to_table: :champions }, null: false

      t.belongs_to :winner, index: true, foreign_key: { to_table: :champions }, null: true
      t.belongs_to :loser, index: true, foreign_key: { to_table: :champions }, null: true
      t.timestamps
    end
  end
end
