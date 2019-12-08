input = File.open('input.txt').read.split(',').map(&:to_i)
require './intcode.rb'

computer = Intcode.new
puts computer.get_output(input, [5])
