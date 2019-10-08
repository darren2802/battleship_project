require_relative '.lib/ship'
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

class ShipTest < Minitest::Test

  def setup
    cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists

    assert_instance_of Ship, cruiser
  end

  def test_name

    assert_equal "Cruiser", cruiser.name
  end

  def test_length_method

    assert_equal 3, cruiser.length
  end

  def test_health_method

    assert_equal 3, cruiser.health
  end

  def test_is_it_sunk?

    refute cruiser.sunk?
  end

  def test_was_it_hit
    cruiser.hit
    assert_equal 2, cruiser.health
    cruiser.hit
    assert_equal 1, cruiser.health
    refute cruiser.sunk?
    cruiser.hit
    assert cruiser.sunk?
  end 

end
