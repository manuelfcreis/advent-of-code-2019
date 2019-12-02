input = File.open('input.txt').read.split(',').map(&:to_i)
input_length = input.length

input[1] = 12
input[2] = 2

## First Exercise

def addition(input, slice)
  input[slice[3]] = input[slice[1]] + input[slice[2]]
end

def multiply(input, slice)
  input[slice[3]] = input[slice[1]] * input[slice[2]]
end

def get_output(input)
   input.each_slice(4) do |slice|
     case slice[0]
     when 1
        addition(input, slice)
     when 2
        multiply(input, slice)
     when 99
        break
     else
        puts "Error on slice #{slice}"
     end
   end

   return input[0]
end


print "Exercise 1: "
puts get_output(input)


## Second Exercise

result = []

(0...99).each do |noun|
   (0...99).each do |verb|
      new_input = File.open('input.txt').read.split(',').map(&:to_i)

      new_input[1] = noun
      new_input[2] = verb

      output = get_output(new_input)

       if output == 19690720
         result = [output, noun, verb]
         break
       end
   end

   break if result[0] == 19690720
end

print "Noun: "
puts result[1]

print "Verb: "
puts result[2]
