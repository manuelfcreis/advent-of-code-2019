require 'pp'

inputs_1 = File.open('input.txt').read.split(',')
inputs_2 = File.open('input2.txt').read.split(',')

wire1 = []
wire2 = []

## Exercise 1

def interpret_path(path, wire)
    position = wire[-1] || [0,0]
    number = path.slice(1, path.length).to_i

    case path[0]
    when "R"
        (1..number).map { |n| wire.append([position[0] + n, position[1]]) }
    when "L"
        (1..number).map { |n| wire.append([position[0] - n, position[1]]) }
    when "U"
        (1..number).map { |n| wire.append([position[0], position[1] + n]) }
    when "D"
        (1..number).map { |n| wire.append([position[0], position[1] - n]) }
    end

    return wire
end

inputs_1.each_with_index do |input, index|
    interpret_path(input, wire1)
end

inputs_2.each_with_index do |input, index|
    interpret_path(input, wire2)
end

matches = wire1 & wire2

man_dist = matches.map do |match|
    match[0].abs + match[1].abs
end

print "Minimum distance: "
pp man_dist.min

## Exercise 2

steps = matches.map do |match|
    wire1.index(match) + wire2.index(match) + 2
end

print "Minimum steps: "
pp steps.min