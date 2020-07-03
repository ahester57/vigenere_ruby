# Hester_Project1.rb
# ruby 2.6.6p146 (2020-03-31 revision 67876) [x64-mingw32]

require_relative 'Vigenere.rb'
require 'concurrent'

class Hester_Project1
	def initialize
        menu
	end

    def menu
        puts( "\n1:\tVigenere" )
        puts( "2:\tUnit Test" )
        puts( "0:\tExit" )
        response = readline
        case response.chars[0]
        when "1"
            menu_vigenere
        when "2"
            menu_test
        when "0"
            "Goodbye."
        else
            menu
        end
    end

    def menu_vigenere
        puts( "\nEnter plain text: " )
        plain_text = readline
        puts( "Enter key: " )
        key = readline
        puts( "Cipher Text: " + cipher_text = encrypt_vigenere( plain_text, key ) )
        puts( "Plain Text: " + decoded_cipher_text = decrypt_vigenere( cipher_text, key ) )
        p(
            :plain_text => plain_text,
            :key => key,
            :cipher_text => cipher_text,
            :decoded_cipher_text => decoded_cipher_text
        )
        menu
    end

    def encrypt_vigenere(plain_text, key)
        cipher_text = Vigenere.new.encrypt( plain_text, key )
    end

    def decrypt_vigenere(cipher_text, key)
        decoded_cipher_text = Vigenere.new.decrypt( cipher_text, key )
    end
    
    def menu_test
        puts( "\nTest Menu" )
        puts( "1:\tTest Vigenere" )
        puts( "0:\tExit" )
        response = readline
        case response.chars[0]
        when "1"
            tr = TestRunner.new
            tr.await.run_vigenere
        when "0"
            menu
        else
            menu_test
        end
    end

    class TestRunner
        include Concurrent::Async

        def run_vigenere
            require_relative 'TestVigenere.rb'
            TestVigenere.new("test_vigenere")
        end
    end
end


Hester_Project1.new

