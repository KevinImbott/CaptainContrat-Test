class Battle < ApplicationRecord
  enum status: { pending: 0, ongoing: 1, finished: 2 }

  belongs_to :champion, class_name: 'Champion'
  belongs_to :opponent, class_name: 'Champion'

  belongs_to :recap, optional: true


  def fight!
    while champion.health.positive? && opponent.health.positive?
        if champion.health.positive?
            faster_champion.attack!(slower_champion)
        end
        if slower_champion.health.positive?
            slower_champion.attack!(faster_champion)
        end
    end
    winner = champion.health.positive? ? champion : opponent
    loser = champion.health.positive? ? opponent : champion

    Recap.create!(winner: winner, loser: loser)
  end

  def faster_champion
    champion.speed > opponent.speed ? champion : opponent
  end

  def slower_champion
    champion.speed > opponent.speed ? opponent : champion
  end
end
