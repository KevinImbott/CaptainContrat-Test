class Perso < ApplicationRecord
  validates :name, presence: true
  validates :health, presence: true
  validates :attack, presence: true
  validates :speed, presence: true
  validates :luck, presence: true
end
