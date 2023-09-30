class CreatePersos < ActiveRecord::Migration[7.0]
  def change
    create_table :persos do |t|
      t.string :name, null: false
      t.integer :health, default: 10
      t.integer :attack, default: 1
      t.integer :speed, default: 1
      t.integer :luck, default: 1

      t.integer :level, default: 1
      t.float :experience, default: 0.0

      t.index :name, unique: true
      t.timestamps
    end
  end
end
