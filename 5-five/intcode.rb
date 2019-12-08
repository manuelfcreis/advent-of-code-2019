## First Exercise

class Intcode
  def get_values(slice, diagnostic)
    instruction = slice[0].to_s.split('').map(&:to_i)

    while instruction.length < 5
      instruction.prepend(0)
    end

    while slice.length < 4
      slice.append(0)
    end

    value_1 = instruction[2] == 1 ? slice[1] : diagnostic[slice[1]]
    value_2 = instruction[1] == 1 ? slice[2] : diagnostic[slice[2]]
    value_3 = slice[3]

    return [value_1, value_2, value_3]
  end

  def addition(index, diagnostic)
    slice = diagnostic.slice(index, 4)

    result = get_values(slice, diagnostic)

    diagnostic[result[2]] = result[0] + result[1]

    return index + 4
  end

  def multiply(index, diagnostic)
    slice = diagnostic.slice(index, 4)
    result = get_values(slice, diagnostic)

    diagnostic[result[2]] = result[0] * result[1]

    return index + 4
  end

  def input_number(index, diagnostic, number)
    slice = diagnostic.slice(index, 2)
    result = get_values(slice, diagnostic)

    diagnostic[slice[1]] = number

    return index + 2
  end

  def output_number(index, diagnostic)
    slice = diagnostic.slice(index, 2)
    result = get_values(slice, diagnostic)

    return [index + 2, diagnostic[slice[1]]]
  end

  def jump_if_true(index, diagnostic)
    slice = diagnostic.slice(index, 3)
    values = get_values(slice, diagnostic)

    if values[0] != 0
      return values[1]
    else
      return index + 3
    end
  end

  def jump_if_false(index, diagnostic)
    slice = diagnostic.slice(index, 3)
    values = get_values(slice, diagnostic)

    if values[0] == 0
      return values[1]
    else
      return index + 3
    end
  end

  def less_than(index, diagnostic)
    slice = diagnostic.slice(index, 4)
    values = get_values(slice, diagnostic)

    diagnostic[values[2]] = values[0] < values[1] ? 1 : 0

    return index + 4
  end

  def equals(index, diagnostic)
    slice = diagnostic.slice(index, 4)

    values = get_values(slice, diagnostic)

    diagnostic[values[2]] = values[0] == values[1] ? 1 : 0

    return index + 4
  end

  def get_output(diagnostic, numbers)
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
                instruction = 9
                return '0'
              end

      instruction = diagnostic[index].to_s[-1].to_i
    end

    return outputs[-1]
  end
end