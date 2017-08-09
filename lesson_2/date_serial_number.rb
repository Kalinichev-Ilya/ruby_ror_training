# Three digits are given, which denote the number,
# month, year (requested from the user). Find the ordinal
# number of the date, starting counting from the beginning
# of the year. Consider that a year can be a leap year

puts 'Enter data separated by a space.(12 12 2012)'
data = gets.chomp.split ' '

days = data[0].to_i
month = data[1].to_i
year = data[2].to_i

days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

# find count of days in all months
result = 0
days_in_months.length.times do |num|
  result += days_in_months[num] if num < month - 1
end

def leap?(year)
  ((year % 4).zero? && year % 100 != 0) || (year % 4).zero?
end

puts result += if leap?(year)
                 days + 1 if month > 1
               else
                 days
               end
