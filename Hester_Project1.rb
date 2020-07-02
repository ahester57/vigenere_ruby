# Hester_Project1.rb
# ruby 2.6.6p146 (2020-03-31 revision 67876) [x64-mingw32]

require_relative 'Vigenere.rb'

v = Vigenere.new("Dogs ar4e Good!2");
puts(v.encrypt("cat"))
puts(v.decrypt_with_key("cat"))
puts(v.decrypt_with_known_plain_text_key_length("dogs", 3))