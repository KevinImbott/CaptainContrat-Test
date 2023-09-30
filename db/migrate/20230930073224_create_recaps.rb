class CreateRecaps < ActiveRecord::Migration[7.0]
  def change
    create_table :recaps do |t|
      t.belongs_to :winner, index: true, foreign_key: { to_table: :champions }, null: false
      t.belongs_to :loser, index: true, foreign_key: { to_table: :champions }, null: false
      t.timestamps
    end
  end
end
