class Champion < ApplicationRecord
  validates :name, presence: true
  validates :health, presence: true
  validates :attack, presence: true
  validates :speed, presence: true
  validates :luck, presence: true

  has_many :winned_fights, class_name: 'Battle', foreign_key: 'winner_id'
  has_many :lossed_fights, class_name: 'Battle', foreign_key: 'loser_id'
  has_many :equipments, dependent: :destroy
  has_many :equiped_equipments, -> { where(equipped: true) }, class_name: 'Equipment'
  has_many :unequiped_equipments, -> { where(equipped: false) }, class_name: 'Equipment'
  has_one_attached :avatar
  
  scope :by_descending_level, -> { order(level: :desc) }
  scope :by_ascending_level, -> { order(level: :asc) }

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


    log = "#{name} attack #{other_champion.name}<br>"
    if other_champion.faster_enough?
      return "#{other_champion.name} is so fast that he dodges the attack<br>"
    end

    log += other_champion.defend(total_attack)
  end

  def defend(attack)
    dmg_taken = damage_taken(attack)

    log = "#{name} loses #{dmg_taken} health points<br>"
    self.health -= dmg_taken
    log += "#{name} has #{health} health points left<br><br>"
    log += "#{name} is dead<br><br>" if health <= 0
    log
  end

  def generate_equipment!
    Equipment.create(
      champion: self
    )
  end

  def damage_taken(attack)
    total_defense - attack > 0 ? 0 : attack - total_defense
  end

  # Attributes

  def lucky_enough?
    total_luck > rand(100)
  end

  def faster_enough?
    total_speed > rand(100)
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

  def total_attack
    attack + weapon&.damage.to_i
  end

  def total_defense
    equiped_equipments.sum(:defense)
  end

  def total_luck
    luck + gauntlet&.luck.to_i
  end

  def total_speed
    speed + boots&.speed.to_i
  end

  def wins!
    gain_xp
    generate_equipment!
  end

  # Equipment
  def weapon
    equiped_equipments.where(type: 'Weapon').first
  end

  def shield
    equiped_equipments.where(type: 'Shield').first
  end

  def helmet
    equiped_equipments.where(type: 'Helmet').first
  end

  def chest
    equiped_equipments.where(type: 'Chest').first
  end

  def gauntlet
    equiped_equipments.where(type: 'Gauntlet').first
  end

  def boots
    equiped_equipments.where(type: 'Boot').first
  end
end
