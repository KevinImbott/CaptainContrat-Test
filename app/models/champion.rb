class Champion < ApplicationRecord
  validates :name, presence: true
  validates :health, presence: true
  validates :attack, presence: true
  validates :speed, presence: true
  validates :luck, presence: true

  scope :by_descending_level, -> { order(level: :desc) }

  has_one_attached :avatar

  has_many :winned_fights, class_name: 'Battle', foreign_key: 'winner_id'
  has_many :lossed_fights, class_name: 'Battle', foreign_key: 'loser_id'

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

  def attack!(other_champion)
    # if self.lucky_enough?
    #   attack += 10
    # end

    if other_champion.faster_enough?
      return "#{champion.name} is so fast that he dodges the attack\n"
    end

    other_champion.defend(attack)
  end

  def defend(attack)
    # if self.shield?
    #   attack -= shield.defense
    # end

    dmg_taken = attack

    log = "#{name} defends\n"
    log += "#{name} loses #{dmg_taken} health points\n"
    self.health -= dmg_taken
    log += "#{name} has #{health} health points left\n"
    log += "#{name} is dead\n\n" if health <= 0
    log
  end

  def lucky_enough?
    luck > rand(100)
  end

  def faster_enough?
    speed > rand(100)
  end

  def level_up!
    self.level += 1
    self.health += 10
    self.attack += 10
    self.speed += 10
    save
  end

  def gain_xp
    self.experience += 50
    if experience >= 100
      level_up!
      self.experience = 0
    end
    save
  end
end
