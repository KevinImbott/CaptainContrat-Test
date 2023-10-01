class Battle < ApplicationRecord
  belongs_to :champion, class_name: 'Champion'
  belongs_to :opponent, class_name: 'Champion'

  enum status: { pending: 0, completed: 1 }

  belongs_to :winner, class_name: 'Champion', optional: true
  belongs_to :loser, class_name: 'Champion', optional: true

  after_initialize :fight!

  def fight!
    return unless pending?

    turn = 0
    log = '---- BATTLE LOG ----\n\n'
    while champion.health.positive? && opponent.health.positive?
      log += "TURN #{turn += 1}\n\n"
      if champion.health.positive?
        log += "#{faster_champion.name} attack #{slower_champion.name}\n"
        log += faster_champion.attack!(slower_champion)
      end
      if slower_champion.health.positive?
        log += "#{slower_champion.name} attack #{faster_champion.name}\n"
        log += slower_champion.attack!(faster_champion)
      end
    end
    wins!
    losses!
    log += "#{winner.name} wins!\n"
    log += "#{loser.name} loses!\n"
    self.log = log

    self.status = :completed
    save!
  end

  def wins!
    self.winner = champion.health.positive? ? champion : opponent
    winner.gain_xp
  end

  def losses!
    self.loser = champion.health.positive? ? opponent : champion
  end

  def faster_champion
    champion.speed > opponent.speed ? champion : opponent
  end

  def slower_champion
    champion.speed > opponent.speed ? opponent : champion
  end
end
