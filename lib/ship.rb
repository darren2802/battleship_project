class Ship

  attr_reader :name,
              :length,
              :health

  def initialize(ship_name, length)
    @name = ship_name
    @length = length
    @health = length
  end
#returns a value for some reason
  def hit
    @health -= 1 # @health -= 1 if @health > 0
  end

  def sunk?
    @health == 0
  end

end
