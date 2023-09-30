class Recap < ApplicationRecord
  belongs_to :winner, class_name: 'Champion'
  belongs_to :loser, class_name: 'Champion'

#   before_create :fight!

#   private

#   def fight!
#     byebug
#   end

#   def faster_perso
#     if perso1.speed > perso2.speed
#         perso1
#     else
#         perso2
#     end
#   end
end
