class Battle < ApplicationRecord
  belongs_to :champion, class_name: 'Champion'
  belongs_to :opponent, class_name: 'Champion'

  belongs_to :winner, class_name: 'Champion', optional: true
  belongs_to :loser, class_name: 'Champion', optional: true


  def fight!
    while champion.health.positive? && opponent.health.positive?
        if champion.health.positive?
            faster_champion.attack!(slower_champion)
        end
        if slower_champion.health.positive?
            slower_champion.attack!(faster_champion)
        end
    end
    wins!
    losses!

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
