class Equipment < ApplicationRecord
    self.table_name = "equipments"

    TYPES = %w[Weapon Shield Helmet Gauntlet Boot Chest Gauntlet]

    enum rarity: { common: 0, uncommon: 1, rare: 2, epic: 3, legendary: 4 }

    after_create :set_defaults

    belongs_to :champion

    def set_defaults
        random_rarity
        set_level
        random_type
        equip
        save
    end

    def random_rarity
        self.rarity = rand(0..4)
    end

    def equip
        champion.equiped_equipments.where(type: type).each do |equipment|
            equipment.unequip
        end
        self.equipped = true
        save
    end

    def set_level
        self.level = champion.level
    end

    def random_type
        return if type.present?
        self.type = TYPES.sample
    end

    def unequip
        self.equipped = false
        save
    end
    
    def self.types
        TYPES
    end
end
