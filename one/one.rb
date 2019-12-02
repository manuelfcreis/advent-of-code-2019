require 'csv'

inputs = CSV.parse(File.open('input.csv'), headers: false).flatten.map(&:to_i)

## First Exercise
result = 0

inputs.each do |input|
  result += input / 3 - 2
end

print 'First answer: '
puts result

## Second Exercise


def calculate_fuel(mass)
  fuel = mass / 3 - 2

  if fuel > 0
    fuel + calculate_fuel(fuel)
  else
     0
  end
end

result_2 = 0

inputs.each do |input|
  result_2 += calculate_fuel(input)
end

print 'Second answer: '
puts result_2
