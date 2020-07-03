# Hester_Project1.rb
# ruby 2.6.6p146 (2020-03-31 revision 67876) [x64-mingw32]

require_relative 'Vigenere.rb'

key = "cat"
plain_text = "azogs ar4e Good!2"
v = Vigenere.new;
cipher_text = v.encrypt(plain_text, key)
decoded_cipher_text = v.decrypt(cipher_text, key)

p(:plain_text => plain_text, :cipher_text => cipher_text, :decoded_cipher_text => decoded_cipher_text)

