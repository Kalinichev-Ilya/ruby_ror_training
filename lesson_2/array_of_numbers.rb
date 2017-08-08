# Fill an array with numbers from 10 to 100 in increments of 5

array = []
(10..100).step(5) do |i|
  array << i
end
puts array
