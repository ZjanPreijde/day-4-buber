class SpaceTaxi
  attr_accessor :number, :passenger, :destination, :rides

  def initialize(number, passenger = nil, destination = "", rides = [])
    @number = number
    @passenger = passenger
    @destination = destination
    @rides = rides
  end

  def to_s
    case
    when is_available?
      "is available"
    when is_reserved?
      "is reserved by #{@passenger.to_s}"
    else
      "is on it's way with #{@passenger.to_s} to \"#{@destination}\""
    end
  end

  def is_available?
    @passenger.nil?
  end

  def is_reserved?
    !is_available? && @destination.empty?
  end

  def is_occupied?
    !(is_available? || is_reserved?)
  end

  def cancel_reservation
    @passenger = nil
  end

  def has_arrived
    # Store finished ride
    @rides << {passenger: @passenger.to_s, destination: @destination}
    # Reset variables
    @destination = ""
    cancel_reservation
  end
end
