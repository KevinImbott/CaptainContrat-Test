class Champion < ApplicationRecord
  validates :name, presence: true
  validates :health, presence: true
  validates :attack, presence: true
  validates :speed, presence: true
  validates :luck, presence: true

  scope :by_descending_level, -> { order(level: :desc) }

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

  def attack!(champion)
    p "#{id} attacks #{champion.id}"
    champion.defend(attack)
  end

  def defend(attack)
    p "#{id} defends"
    p "#{id} loses #{attack / 2} health points"
    self.health -= attack / 2
    p "#{id} has #{health} health points left"
    p "#{id} is dead" if health <= 0
  end

  def level_up!
    self.level += 1
    self.health += 10
    self.attack += 10
    self.speed += 10
    self.save
  end

  def gain_xp
    self.xp += 10
    if xp >= 100
      level_up
      self.xp = 0
    end
  end
end
