# Fill the hash with a vowel where value is the
# alphabetic sequence number of the letter (a - 1).

chars = ('a'..'z').to_a
vowels = %w[a e i o]

alphabet = {}
chars.each.with_index(1) do |char, i|
  alphabet[char] = i if vowels.include? char
end

alphabet.each { |key, val| puts "#{key}: #{val}" }
