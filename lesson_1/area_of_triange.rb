# Площадь треугольника.
# Площадь треугольника можно вычилсить,
# зная его основание (a) и высоту (h) по формуле: 1/2*a*h.
# Программа должна запрашивать основание и высоту треуголиника
# и возвращать его площадь.

class AreaOfTriangle
  def initialize(a, h)
    @a = a
    @h = h
  end

  def area
    1.0 / (2 * @a * @h)
  end
end

puts 'Please input base of triangle:'
a = gets.chomp.to_i
puts 'Please input base of triangle:'
h = gets.chomp.to_i

triangle = AreaOfTriangle.new(a, h)
print triangle.area
