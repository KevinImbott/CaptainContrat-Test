class Equipment < ApplicationRecord
    self.table_name = "equipments"
    
    TYPES = %w[Weapon Shield Helmet Gauntlet Boot Chest]
    
    enum rarity: { common: 0, uncommon: 1, rare: 2, epic: 3, legendary: 4 }

    scope :equipped, -> { where(equipped: true) }
    scope :unequipped, -> { where(equipped: false) }

    scope :weapon, -> { where(type: "Weapon") }
    scope :shield, -> { where(type: "Shield") }
    scope :helmet, -> { where(type: "Helmet") }
    scope :gauntlet, -> { where(type: "Gauntlet") }
    scope :boot, -> { where(type: "Boot") }
    scope :chest, -> { where(type: "Chest") }

    scope :common, -> { where(rarity: "common") }
    scope :uncommon, -> { where(rarity: "uncommon") }
    scope :rare, -> { where(rarity: "rare") }
    scope :epic, -> { where(rarity: "epic") }
    scope :legendary, -> { where(rarity: "legendary") }

    after_create :set_defaults

    belongs_to :champion

    def set_defaults
        random_rarity
        set_level
        random_type
        set_attribute
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

    def set_attribute
        case type
        when "Weapon"
            self.damage = rarity_randomizer * level
        when "Shield"
            self.defense = rarity_randomizer * level
        when "Helmet"
            self.defense = rarity_randomizer * level
        when "Gauntlet"
            self.luck = rarity_randomizer * level
        when "Boot"
            self.speed = rarity_randomizer * level
        else
            self.defense = rarity_randomizer * level
        end
    end

    def rarity_randomizer
        case rarity
        when "common"
            rand(1..3)
        when "uncommon"
            rand(2..4)
        when "rare"
            rand(3..6)
        when "epic"
            rand(5..7)
        when "legendary"
            rand(7..10)
        end
    end

    def unequip
        self.equipped = false
        save
    end
    
    def self.types
        TYPES
    end
end
