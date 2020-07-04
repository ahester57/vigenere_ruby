# Vigenere.rb
# ruby 2.6.6p146 (2020-03-31 revision 67876) [x64-mingw32]

class Vigenere

    def encrypt(plain_text, key)
        # Encode 'plain_text' using vigenere cipher and 'key' as the key
        run_vigenere(
            VigenereUtil.text_to_array( plain_text ),
            VigenereUtil.text_to_array( key ),
            1
        )
    end

    def decrypt(cipher_text, key)
        # Decode 'cipher_text' using vigenere cipher and 'key' as the key
        run_vigenere(
            VigenereUtil.text_to_array( cipher_text ),
            VigenereUtil.text_to_array( key ),
             -1
        )
    end

    private def run_vigenere(text_array, key_array, adj)
        # adj -> postive = encode, negative = decode
        coded_text = vigenere_algorithm( text_array, key_array, (adj == 0 ? 1 : adj.abs / adj) )
                        .map { |x| VigenereUtil.n_to_l( x ) }
                        .join('')
        # VigenereUtil.display_results( text_array.join(''), coded_text )
        coded_text
    end

    private def vigenere_algorithm(text_array, key_array, adj)
        numeric_text_array = []
        k = 0
        for i in 0..text_array.length-1
            k_i = VigenereUtil.l_to_n( key_array[k] )
            numeric_text_array[i] = ( VigenereUtil.l_to_n( text_array[i] ) + (k_i * adj) ) % 26
            k = (k + 1) % key_array.length
        end
        numeric_text_array
    end
end

class VigenereUtil
    # the next line is an 'Eigenclass', which simulates static methods in Ruby
    # src: http://nicholasjohnson.com/ruby/ruby-course/exercises/static-methods/
    class << VigenereUtil

        def letter?(lookAhead)
            # return true if a letter, false otherwise
            # src: https://stackoverflow.com/questions/14551256/ruby-how-to-find-out-if-a-character-is-a-letter-or-a-digit
            lookAhead =~ /[[:alpha:]]/
        end

        def l_to_n(letter)
            # return number value for letter a = 0, b = 1, c = 2, ..., z = 25
            letter.ord - 97
        end

        def n_to_l(number)
            # return letter value for number 0 = a, 1 = b, 2 = c, ..., 25 = z, 26 = a, 27 = b, ...
            [(number % 26) + 97].pack('U')
        end

        def text_to_array(text)
            # in Ruby, every method returns the result of the last line of the method, kinda like Lisp
            reject_all_but_letters( text.downcase.chars )
        end

        private def reject_all_but_letters(input)
            input.reject { |x| !VigenereUtil.letter?( x ) }
        end

        def display_results(orig, post)
            # Original:
            puts( "Original: " + orig )
            # Coded:
            puts( "Coded: " + post )
        end
    end
end

