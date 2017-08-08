basket = {}

total_price = 0
total_count = 0

puts '/exit/ for quit'

exit = false
until exit
  print 'Product name: '
  product = gets.chomp.downcase

  # input loop
  if product == 'exit'
    exit = true
  else
    total = {}
    basket[product] = ''

    print 'Price: '
    price = gets.chomp.to_i
    total[price] = ''

    print 'Count: '
    count = gets.chomp.to_f

    # added in hash basket => {price, count}
    total[price] = count
    basket[product] = total

    # summ total price
    total.each do |full_price, counting|
      total_price += full_price
      total_count += counting
    end
  end

  # intermediate result
  puts '---------BASKET----------'
  basket.each do |name, all|
    print "#{name}: "
    all.each do |money, count_|
      puts "#{money} * #{count_} = #{money * count_}"
    end
  end
  puts '-------------------------'
end

puts "------ Total #{total_price * total_count} -------"
