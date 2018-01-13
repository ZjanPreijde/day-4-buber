require_relative 'buber'

# 20 space taxis? A bit too many to my taste
NR_OF_SPACE_TAXIS = 4
# 20 seconds sleep time? A bit too long to my taste
SLEEP_TIME = 2

# Define taxis on duty at the moment
space_taxis = []
for counter in 1..NR_OF_SPACE_TAXIS
  space_taxis.push(add_taxi(counter))
end

done = false
passenger = nil
until done
  passenger = nil
  taxi = nil
  address = ""

  # Get passenger info, 'Exit' ends application
  passenger, done = get_passenger()
  if !(done || passenger.nil?)
    # List status taxis,
    #  return available taxis
    available_taxis = list_status(space_taxis)
    # Ask user to choose an available taxi
    taxi = get_taxi(space_taxis, available_taxis)
  end

  # Assume occupied taxis have arrived at destination
  space_taxis.each do |taxi|
    if taxi.is_occupied?
      taxi.has_arrived
    end
  end

  if !taxi.nil?
    # Available taxi chosen,
    #  reserve taxi for passenger
    taxi.passenger = passenger
    # Get destination
    destination = get_destination
    if destination.empty?
      # No destination entered,
      #  cancel reservation
      taxi.cancel_reservation
    else
      # Add destination to taxi
      taxi.destination = destination
    end
  end

  # Sleep
  if !done
    for i in 1..SLEEP_TIME
      print 'z' * 4
      sleep(1)
    end
    print "\n"
    end
end
list_final(space_taxis)
