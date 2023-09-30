class Perso < ApplicationRecord
  validates :name, presence: true
  validates :health, presence: true
  validates :attack, presence: true
  validates :speed, presence: true
  validates :luck, presence: true

  has_one_attached :avatar

  has_many :winned_fights, class_name: 'Recap', foreign_key: 'winner_id'
  has_many :lossed_fights, class_name: 'Recap', foreign_key: 'loser_id'

  def wins
    winned_fights.count
  end

  def losses
    lossed_fights.count
  end

  def win_rate
    return 0 if wins.zero?

    (wins.to_f / (wins + losses)).round(2) * 100
  end

  private

  # def attack(perso)
  #   perso.defend(attack)
  # end

  def defend(attack)
    perso.health -= attack / 2
  end

  def level_up
    self.level += 1
    self.health += 10
    self.attack += 10
    self.speed += 10
  end

  def gain_xp
    self.xp += 10
    if xp >= 100
      level_up
      self.xp = 0
    end
  end
end
