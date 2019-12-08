input = File.open('input.txt').read

def create_images(height, width, input)
  layers = []

  input = input.split('').map(&:to_i)

  input.each_slice(height * width) do |layer|
    layers.append(layer)
  end

  return layers
end

width = 25
height = 6
layers = create_images(height, width, input)
min_layer = layers.min_by { |l| l.count(0)}

print "Exercise 1: "
puts min_layer.count(1) * min_layer.count(2)

puts '---'
## Exercise

final_image = (0...width).map { Array.new(height) }

layers.each do |layer|
  vertical_index = 0
  horizontal_index = 0

  layer.each_slice(width) do |horizontal|
    horizontal_index = 0
    horizontal.each do |cell|
      if final_image[vertical_index][horizontal_index].nil?
        if cell == 2
          final_image[vertical_index][horizontal_index] = nil
        elsif cell == 1
          final_image[vertical_index][horizontal_index] = 'W'
        elsif cell == 0
          final_image[vertical_index][horizontal_index] = 'B'
        end
      end

      horizontal_index += 1
    end

    vertical_index +=1
  end
end

final_image.each do |row|
  print row
  puts ' '
end