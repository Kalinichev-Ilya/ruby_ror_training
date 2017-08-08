# Three digits are given, which denote the number,
# month, year (requested from the user). Find the ordinal
# number of the date, starting counting from the beginning
# of the year. Consider that a year can be a leap year

puts 'Enter data separated by a space.(12 12 2012)'
data = gets.chomp.split ' '

days = data[0].to_i
month = data[1].to_i
year = data[2].to_i

# find count of days by month number
def count_of_days_in(month)
  28 + (month + (month / 8)) % 2 + 2 % month + 2 * (1 / month)
end


# find count of days in all months
result = 0
(1..month).each do |_res_count_days|
  result += count_of_days_in(month)
end

# if year is leap +1 day
divided_into_four = (year % 4).zero?
not_divided_into_one_hundred = year % 100 != 0

puts result += if (divided_into_four && not_divided_into_one_hundred) || divided_into_four
                 days + 1
               else
                 days
          end
