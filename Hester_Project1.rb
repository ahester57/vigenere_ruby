# Hester_Project1.rb
require_relative 'Vigenere.rb'

v = Vigenere.new("dogs are good");
puts(v.encrypt("cat"))
puts(v.decrypt_with_key("cat"))
puts(v.decrypt_with_known_plain_text_key_length("dogs", 3))