class Perso < ApplicationRecord
  validates :name, presence: true
  validates :health, presence: true
  validates :attack, presence: true
  validates :speed, presence: true
  validates :luck, presence: true

  has_one_attached :avatar

  has_many :winned_fights, class_name: 'Fight', foreign_key: 'winner_id'
  has_many :lossed_fights, class_name: 'Fight', foreign_key: 'loser_id'

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
end
