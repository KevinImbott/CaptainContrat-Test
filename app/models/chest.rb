class Chest < Equipment
    self.table_name = "equipments"

    # before_create :set_defense

    # def set_defense
    #     rarity = self.rarity

    #     self.update(defense: champion.level * 10)
    # end

end
