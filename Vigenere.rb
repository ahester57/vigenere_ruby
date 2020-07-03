# Vigenere.rb
# ruby 2.6.6p146 (2020-03-31 revision 67876) [x64-mingw32]

class Vigenere

    def encrypt(plain_text, key)
        # Encode 'plain_text' using vigenere cipher and 'key' as the key
        run_vigenere(plain_text, key, 1)
    end

    def decrypt(cipher_text, key)
        # Decode 'cipher_text' using vigenere cipher and 'key' as the key
        run_vigenere(cipher_text, key, -1)
    end

    def run_vigenere(text, key, adjuster)
        text_array = VigenereUtil.text_to_array(text)
        split_key = VigenereUtil.text_to_array(key)
        numeric_text = vigenere_algorithm(text_array, split_key, adjuster)
        coded_text = numeric_text.map { |x| VigenereUtil.number_to_letter(x) }
        # VigenereUtil.display_results(cipher_text, cipher_text_array, decoded_cipher_text)
        coded_text.join('')
    end

    def vigenere_algorithm(text_array, key_array, adjuster)
        numeric_text_array = []
        k = 0
        for i in 0..text_array.length-1
            k_i = VigenereUtil.letter_to_number(key_array[k])
            x = (VigenereUtil.letter_to_number(text_array[i]) + (k_i * adjuster)) % 26
            numeric_text_array[i] = x
            k += 1
            if (k >= key_array.length) then
                k = 0
            end
        end
        return numeric_text_array
    end

    def brute_force_known_substr(cipher_text, plain_substr, key_length)
        substr = VigenereUtil.plain_text_to_array(substr)
        p substr
        @cipher_text.join('')
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

        def letter_to_number(letter)
            # return number value for letter a = 0, b = 1, c = 2, ..., z = 25
            letter.ord - 97
        end

        def number_to_letter(number)
            # return letter value for number 0 = a, 1 = b, 2 = c, ..., 25 = z, 26 = a, 27 = b, ...
            [(number % 26) + 97].pack('U')
        end

        def text_to_array(text)
            # in Ruby, every method returns the result of the last line of the method, kinda like Lisp
            reject_all_but_letters(text.downcase.chars)
        end

        def reject_all_but_letters(input)
            input.reject { |x| !VigenereUtil.letter?(x) }
        end

        def display_results(orig, trim, post)
            # Original:
            puts(orig)
            # Trimmed
            puts(trim.join(''))
            # Deccoded:
            puts(post.join(''))
        end
    end
end