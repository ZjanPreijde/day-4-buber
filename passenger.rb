class Passenger
  def initialize(first_name = "", last_name = "", age = 0)
    @first_name = first_name
    @last_name = last_name
    @age = age
  end

  def to_s
    "\"#{@first_name} #{@last_name}\" (Age: #{@age})"
  end
end
