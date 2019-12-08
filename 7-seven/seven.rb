require '../5-five/intcode.rb'

input = File.open('test_input.txt').read.split(',').map(&:to_i)

class Intcode
  def highest_signal_for_thrusters(input, amplifier_values)
    amplifier_values = amplifier_values.permutation.to_a
    signals = []
    second_number = 0

    amplifier_values.each do |values|
      values.each do |first_number|
        input_copy = input.dup
        second_number = get_output(input_copy, [first_number, second_number])
      end

      signals.append(second_number)
      second_number = 0
    end

    return signals.max
  end

  def get_loop_output(diagnostic, numbers)
    index = 0
    number_index = 0
    outputs=[]
    instruction = diagnostic[index].to_s[-1].to_i

    until instruction == 9
      index = case instruction
              when 1 then addition(index, diagnostic)
              when 2 then multiply(index, diagnostic)
              when 3
                index = input_number(index, diagnostic, numbers[number_index])
                number_index += 1
                index
              when 4 then
                results = output_number(index, diagnostic)
                outputs.append(results[1])
                results[0]
              when 5 then jump_if_true(index, diagnostic)
              when 6 then jump_if_false(index, diagnostic)
              when 7 then less_than(index, diagnostic)
              when 8 then equals(index, diagnostic)
              else
                puts instruction
                puts "Error on index #{index}"
                return 'end'
              end

      instruction = diagnostic[index].to_s[-1].to_i
    end

    return outputs[-1]
  end

  def amplifier_feedback(input, amplifier_values)
    amplifier_values = amplifier_values.permutation.to_a
    outputs = []
    output = 0

    amplifier_values.each do |values|
      local_outputs = []
      index = 0

      until output == 'end'
        # input_copy = input.dup
        output = get_loop_output(input, [values[index], output])

        if index == 4
          local_outputs.append(output)
          print local_outputs
          puts '--'

          index = 0
        else
          index += 1
        end
      end

      outputs = local_outputs[-1]
    end

    return outputs.max
  end
end

computer = Intcode.new

# print "Exercise 1: "
# puts computer.highest_signal_for_thrusters(input, [0,1,2,3,4])

print "Exercise 2: "
puts computer.amplifier_feedback(input, [5,6,7,8,9])
