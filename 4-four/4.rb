range = (206938..679128)

## Exercise 1

def adjacent_digits(number)
    (0...(number.length - 1)).any? { |i| number[i] == number[i+1] }
end

def dont_decrease(number)
    (0...(number.length - 1)).all? { |i| number[i].to_i <= number[i+1].to_i }
end

possibilities_1 = range.map do |number|
    number = number.to_s.split('')
    if adjacent_digits(number) && dont_decrease(number)
        number
    end
end

print "Possibilities 1: "
puts possibilities_1.compact.length

## Exercise 2

def adjacent_digits_2(number)
    adjacent = (0...(number.length-1)).map { |i| number[i] if number[i] == number[i+1] }.compact

    if adjacent.length > 0
        adjacent.uniq.any? do |a|
            (1...(number.length-1)).all? do |i|
                number[i] != a ||
                    (number[i-1] != number[i] || number[i+1] != number[i])
            end
        end
    else
        false
    end
end

possibilities_2 = range.map do |number|
    number = number.to_s.split('')
    if adjacent_digits_2(number) && dont_decrease(number)
        number
    end
end

print "Possibilities 2: "
puts possibilities_2.compact.length
