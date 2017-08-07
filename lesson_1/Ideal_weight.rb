# Идеальный вес. Программа запрашивает у пользователя имя и рост
# и выводит идеальный вес по формуле <рост> - 110,
# после чего выводит результат пользователю на экран с обращением по имени.
# Если идеальный вес получается отрицательным, то выводится строка "Ваш вес уже оптимальный"

class IdealWeight
  def self.print_result(user)
    puts calculate(user)
  end

  private

  def self.calculate(user)
    if user.weight - 110 < 0
      'Ваш вес уже оптимальный'
    else
      "#{user.name}: #{user.weight - 110}"
    end
  end
end

# User entity
class User
  attr_reader :name, :weight

  def initialize(name, weight)
    @name = name
    @weight = weight
  end
end

puts 'Hello! Please write your name:'
name = gets.chomp
puts '..and your weight:'
weight = gets.chomp.to_i

user = User.new(name, weight)
IdealWeight.print_result(user)
