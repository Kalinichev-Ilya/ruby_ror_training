# Fill the hash with a vowel where value is the
# alphabetic sequence number of the letter (a - 1).

# gets array of all chars alphabet
chars = ('a'..'z').to_a

# get numbers of chars
i = 0
alphabet = {}
chars.each do |char|
  alphabet[char] = i
  i += 1
end

# delete unnecessary chars
result = {}
%w[a e i o].each do |char|
  alphabet.include? char
  result[char] = alphabet[char]
end

result.each { |key, val| puts "#{key}: #{val}" }
