class Battle
  attr_reader :perso1, :perso2

  def initialize(perso1, perso2)
    @perso1 = perso1
    @perso2 = perso2
  end

  def process
    faster_perso.attack(slower_perso)

  end

  private

  def faster_perso
    if perso1.speed > perso2.speed
        perso1
    else
        perso2
    end
  end
end
