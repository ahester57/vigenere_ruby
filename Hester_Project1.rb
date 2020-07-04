# Hester_Project1.rb
# ruby 2.6.6p146 (2020-03-31 revision 67876) [x64-mingw32]

require_relative 'Vigenere.rb'
require_relative 'VigenereBrute.rb'

class Hester_Project1
	def initialize
        $stdout.sync = true
        menu
	end

    private def menu
        puts( "\n1:\tVigenere" )
        puts( "2:\tBrute Force" )
        puts( "3:\tUnit Test" )
        puts( "0:\tExit" )
        response = readline
        case response.chars[0]
        when "1"
            menu_vigenere
        when "2"
            menu_brute
        when "3"
            menu_test
        when "0"
            puts "Goodbye."
        else
            menu
        end
    end

    private def menu_vigenere
        print( "\nEnter plain text: " )
        plain_text = readline
        key = ''
        loop do
            print( "Enter key: " )
            key = VigenereUtil.text_to_array( readline ).join
            break if key.length > 0
        end
        puts( "Cipher Text:\t" + cipher_text = encrypt_vigenere( plain_text, key ) )
        puts( "Decrypt Text:\t" + decoded_cipher_text = decrypt_vigenere( cipher_text, key ) )
        #p(
        #    :plain_text => plain_text,
        #    :key => key,
        #    :cipher_text => cipher_text,
        #    :decoded_cipher_text => decoded_cipher_text
        #)
        menu
    end

    private def encrypt_vigenere(plain_text, key)
        cipher_text = Vigenere.new.encrypt( plain_text, key )
    end

    private def decrypt_vigenere(cipher_text, key)
        decoded_cipher_text = Vigenere.new.decrypt( cipher_text, key )
    end
    
    private def menu_brute
        print( "\nEnter cipher text: " )
        cipher_text = readline
        substr = ''
        loop do
            print( "Enter known substring of plaintext: " )
            substr = VigenereUtil.text_to_array( readline ).join
            break if substr.length > 0
        end
        max_key_size = 0 
        loop do
            print( "Enter max key size (max 10): " )
            res = readline.strip
            begin
                max_key_size = res.to_i
            rescue
                max_key_size = 0
            end
            break if max_key_size > 0 and max_key_size <= 10
        end
        puts( brute_force_vigenere( cipher_text, substr, max_key_size ) )
        menu
    end

    private def brute_force_vigenere(cipher_text, known_substr, max_key_size)
        vig = VigenereBrute.new
        possible_plaintext = []
        continue = true
        for k_length in 1..max_key_size do
            possible_plaintext.push( vig.brute_force_known_substr(cipher_text, known_substr, k_length) )
            print( "Key length #{k_length} done. Continue(y/n)? " )
            begin
                res = readline.strip!.downcase
                case res
                when "n"
                    continue = false
                end
            end until ["y", "n"].include? res
            if not continue then
                break
            end
        end
    end

    private def menu_test
        puts( "\nTest Menu" )
        puts( "1:\tTest Vigenere" )
        puts( "0:\tExit" )
        response = readline
        case response.chars[0]
        when "1"
            tr = TestRunner.new
            tr.run_vigenere
        when "0"
            menu
        else
            menu_test
        end
    end

    class TestRunner
        def run_vigenere
            require_relative 'TestVigenere.rb'
            TestVigenere.new("test_vigenere")
        end
    end
end


Hester_Project1.new

