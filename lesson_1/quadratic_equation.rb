class NegativeDiscriminant < StandardError
end

# Quadratic equation
puts 'Hello! Input three numbers (a, b, c).'
numbers = (0..2).collect { gets.chomp.to_i }

a = numbers[0]
b = numbers[1]
c = numbers[2]
discriminant = b**2 - 4 * a * c

equation_root_one = 0
equation_root_two = 0

begin
  if discriminant > 0
    equation_root_one = (-b + Math.sqrt(discriminant)) / (2 * a)
    equation_root_two = (-b - Math.sqrt(discriminant)) / (2 * a)
  elsif discriminant.zero?
    equation_root_one = equation_root_two = -b / (2 * a)
  elsif discriminant < 0
    raise NegativeDiscriminant, "Discriminant #{discriminant}, the roots of the equation are imaginary numbers."
  end
  puts "Discriminant #{discriminant}, x1 = #{equation_root_one}, x2 = #{equation_root_two}."
rescue NegativeDiscriminant => error
  error.backtrace
end
