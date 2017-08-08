# Идеальный вес. Программа запрашивает у пользователя имя и рост
# и выводит идеальный вес по формуле <рост> - 110,
# после чего выводит результат пользователю на экран с обращением по имени.
# Если идеальный вес получается отрицательным, то выводится строка "Ваш вес уже оптимальный"

puts 'Hello! Please write your name:'
name = gets.chomp
puts '..and your height:'
height = gets.chomp.to_i

message = if height - 110 > 0
            "Your optimal weight: #{height - 110}"
          else
            'Your weight is already optimal'
         end

puts "Hello #{name.capitalize}! #{message}."
