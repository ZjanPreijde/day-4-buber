require_relative 'passenger'
require_relative 'spacetaxi'

def list_status(taxis)
  available = []
  taxis.each_with_index do |taxi, index|
    print "Space taxi #{index + 1}\t #{taxi.to_s}"
    print "\n"
    if taxi.is_available?
      available.push(index)
    end
  end
  return available
end

def list_final(taxis)
  puts "- " * 30
  puts "Summary of Space Taxis usage (status)"
  puts "- " * 30
  taxis.each_with_index do |taxi, index|
    print "Space taxi #{index+ 1 }"
    print "\tNr of rides: #{taxi.rides.length}"
    taxi.rides.each do |ride|
      print "\n\t"
      ride.each do |key,value|
        print "#{key}: #{value}\t"
      end
    end
    print "\n"
  end
  puts "= " * 30
end

def add_taxi(nr)
  SpaceTaxi.new(nr)
end

def get_passenger
  first_name = ""
  last_name = ""
  age = 0
  passenger = nil
  puts "- " * 30
  puts "Hi, for you to hire one of our luxurious Space Taxis, we need some information"
  print "What is your first name? ('exit' ends loop) "
  first_name = gets.chomp
  done = (first_name == "exit")
  if !(done || first_name.empty?)
    print "What is your last name? "
    last_name = gets.chomp
  end
  if !(done || last_name.empty?)
    print "What is your age? "
    age = gets.to_i
  end
  case
  when done
    # End loop
    print "'Exit' entered, leaving application. Good bye"
  when !(first_name.empty? || last_name.empty? || age < 1)
    # All data entered,
    #  create passenger
    passenger = Passenger.new(first_name, last_name, age)
  else
    print "I'm sorry, we need your full details"
  end
  print "\n"
  return passenger, done
end

def get_taxi(taxis, available)
  taxi = nil
  loop do
    print "Please enter the number of an available taxi: "
    taxi_nr = gets.to_i
    case
    when taxi_nr < 1
      puts "Not a valid taxi number entered"
      break;
    when !available.include?(taxi_nr - 1)
      puts "I'm sorry. Taxi #{taxi_nr} is not available"
    else
      taxi = taxis[taxi_nr - 1]
      break;
    end
  end
  return taxi
end

def get_destination
  print "Please enter the destination: "
  destination = gets.chomp
  if destination.empty?
    puts "Sorry, we need a destination"
  end
  return destination
end
