class CreateEquipments < ActiveRecord::Migration[7.0]
  def change
    create_table :equipments do |t|
      t.string :type
      t.integer :rarity
      t.integer :level

      t.boolean :equipped, default: false

      t.belongs_to :champion, index: true, foreign_key: { to_table: :champions }, null: false

      t.integer :damage
      t.integer :defense
      t.integer :speed
      t.integer :luck

      t.timestamps
    end
  end
end
