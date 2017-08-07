# Прямоугольный треугольник.
# Программа запрашивает у пользователя 3 стороны треугольника
# и определяет, является ли треугольник прямоугольным,
# используя теорему Пифагора (www-formula.ru) и выводит результат на экран.
# Также, если треугольник является при этом равнобедренным (т.е. у него равны любые 2 стороны),
# то дополнительно выводится информация о том, что треугольник еще и равнобедренный.
# Подсказка: чтобы воспользоваться теоремой Пифагора, нужно сначала найти самую длинную сторону
# (гипотенуза) и сравнить ее значение в квадрате с суммой квадратов двух остальных сторон.
# Если все 3 стороны равны, то треугольник равнобедренный и равносторонний, но не прямоугольный.

puts 'Please, enter the three sides of the triangle;'
sides = (0..2).collect { gets.chomp.to_i }

count = sides.each_with_object(Hash.new(0)) { |string, hash| hash[string] += 1 }.values.max

if count == 3
  puts 'triangle isosceles and equilateral, but not rectangular'
elsif count == 2
  puts 'triangle is rectangular'
end

hypotenuse = sides.max
sides.delete hypotenuse

sqrt_another_sides = 0
sides.map { |side| sqrt_another_sides += side**2 }

puts "it's right triangle" if hypotenuse**2 == sqrt_another_sides
