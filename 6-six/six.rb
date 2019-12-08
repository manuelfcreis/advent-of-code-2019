inputs = File.open('input.txt').read.gsub(/\n/, ' ').split(' ')

orbits = {}

inputs.each do |input|
  objects = input.split(')')
  if orbits[objects[0]].nil?
    orbits[objects[0]] = []
  end

  orbits[objects[0]].append(objects[1])
end

count = 0


def count_orbiters(orbits, object)
  if orbits[object]
    orbits[object].length +
      orbits[object].map { |o| count_orbiters(orbits, o)}.sum
  else
    0
  end
end

counts = orbits.keys.map do |key|
  count_orbiters(orbits, key)
end

print "Exercise 1: "
puts counts.sum

def find_in_child_orbits(orbits, object, target)
  if orbits[object].nil?
    return false
  elsif orbits[object].include?(target)
    return true
  else
    return orbits[object].any? { |o| find_in_child_orbits(orbits, o, target)}
  end
end

def find_parent(orbits, object)
  orbits.map do |key, values|
    if values.include? object
      return key
      break
    end
  end.compact[0]
end

def find_object(current, final, orbits)
  current_position = find_parent(orbits, current)
  final_position = find_parent(orbits, final)

  count = 0

  until current_position == final_position
    increase_final = !find_in_child_orbits(orbits, final_position, current_position)
    increase_current = !find_in_child_orbits(orbits, current_position, final_position)

    if increase_current
      current_position = find_parent(orbits, current_position)
      count += 1
    end

    if increase_final
      final_position = find_parent(orbits, final_position)
      count += 1
    end
  end

  return count
end

print "Exercise 2: "
puts find_object("YOU", "SAN", orbits)