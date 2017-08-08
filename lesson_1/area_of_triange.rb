# Площадь треугольника.
# Площадь треугольника можно вычилсить,
# зная его основание (a) и высоту (h) по формуле: 1/2*a*h.
# Программа должна запрашивать основание и высоту треуголиника
# и возвращать его площадь.

puts 'Please input base of triangle:'
a = gets.chomp.to_f
puts 'Please input height of triangle:'
h = gets.chomp.to_f

result = 0.5 * a * h

puts "Area of a triangle: #{result}."
