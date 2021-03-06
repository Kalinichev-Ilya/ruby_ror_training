# Make a hash that contains months and the number
# of days in a month. In the cycle, output those
# months, in which the number of days is exactly 30.

months = {
  January: 31,
  February: 29,
  March: 31,
  April: 30,
  May: 31,
  June: 30,
  July: 31,
  August: 31,
  September: 30,
  October: 31,
  November: 30,
  December: 31
}
months.each { |month, days| puts "#{month}: #{days}" if days == 30 }
