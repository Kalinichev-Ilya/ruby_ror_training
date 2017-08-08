# Fill the hash with a vowel where value is the
# alphabetic sequence number of the letter (a - 1).
puts 'Task 4'

# gets array of all chars alphabet
chars = ('a'..'z').to_a
alphabet = Hash.new(0)
i = 0
# get numbers of chars
chars.each do |char|
  alphabet[char] = i
  i += 1
end
# delete unnecessary chars
result = Hash.new(0)
%w[a e i o].each do |char|
  alphabet.include? char
  result[char] = alphabet[char]
end
result.each { |key, val| puts "#{key}: #{val}" }
