class Fight < ApplicationRecord
  belongs_to :winner, class_name: 'Perso'
  belongs_to :loser, class_name: 'Perso'
end
