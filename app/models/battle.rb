class Battle < ApplicationRecord
  enum status: { pending: 0, completed: 1 }
  
  belongs_to :champion, class_name: 'Champion'
  belongs_to :opponent, class_name: 'Champion'
  belongs_to :winner, class_name: 'Champion', optional: true
  belongs_to :loser, class_name: 'Champion', optional: true

  after_create :fight!

  def fight!
    return unless pending?

    turn = 0
    log = '---- BATTLE LOG ----<br><br>'

    log += "#{champion.name} has #{champion.health} health points<br>"
    log += "#{opponent.name} has #{opponent.health} health points<br><br>"

    log += "#{faster_champion.name} begins the fight<br>"
    while champion.health.positive? && opponent.health.positive?
      log += "<br>---- TURN #{turn += 1} ----<br><br>"
      if champion.health.positive?
        log += faster_champion.attack!(slower_champion)
      end
      if slower_champion.health.positive?
        log += slower_champion.attack!(faster_champion)
      end
    end
    set_winner
    set_loser
    log += "#{winner.name} wins! with #{winner.health} health points left<br>"
    self.log = log

    self.status = :completed
    save!
  end

  def set_winner
    self.winner = champion.health.positive? ? champion : opponent
    winner.gain_xp
    winner.generate_equipment!
  end

  def set_loser
    self.loser = champion.health.positive? ? opponent : champion
  end

  def faster_champion
    champion.speed > opponent.speed ? champion : opponent
  end

  def slower_champion
    champion.speed > opponent.speed ? opponent : champion
  end
end
