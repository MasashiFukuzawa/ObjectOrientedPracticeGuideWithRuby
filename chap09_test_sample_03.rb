class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each{|preparer| preparer.prepare_trip(self)}
  end
end

class Mechanic
  def prepare_trip(trip)
    trip.bicycles.each{|bicycle| prepare_bicycle(bicycle)}
  end

  def prepare_bicycle(bicycle)
    # do something
  end
end

class TripCoordinator
  def prepare_trip(trip)
    buy_food(trip.customers)
  end

  def buy_food(customers)
    # do something
  end
end

class Driver
  def prepare_trip(trip)
    vehicle = trip.vehicle
    gas_up(vehicle)
    fill_water_tank(vehicle)
  end

  def gas_up(vehicle)
    # do something
  end

  def fill_water_tank(vehicle)
    # do something
  end
end

module PrepareInterfaceTest
  def test_implements_the_preparer_interface
    assert_respond_to(@object, :prepare_trip)
  end
end

require 'minitest/autorun'

class MechanicTest < MiniTest::Unit::TestCase
  include PrepareInterfaceTest

  def setup
    @mechanic = @object = Mechanic.new
  end
end

class TripCoordinatorTest < MiniTest::Unit::TestCase
  include PrepareInterfaceTest

  def setup
    @trip_coodinator = @object = TripCoordinator.new
  end
end

class DriverTest < MiniTest::Unit::TestCase
  include PrepareInterfaceTest

  def setup
    @driver = @object = Driver.new
  end
end

class TripTest < MiniTest::Unit::TestCase
  @preparer = MiniTest::Mock.new
  @trip     = Trip.new
  @preparer.expect(:prepare_trip, nil, [@trip])

  @trip.prepare([@preparer])
  @preparer.verify
end
