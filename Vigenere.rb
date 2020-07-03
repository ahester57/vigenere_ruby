# Vigenere.rb
# ruby 2.6.6p146 (2020-03-31 revision 67876) [x64-mingw32]

class Vigenere
    attr_accessor(:key, :plain_text)

    def initialize(key, plain_text)
        @key = key
        @plain_text = plain_text
        @cipher_text = nil
    end

    def encrypt()
        # Encode the instance variable 'plain_text' using vigenere cipher and 'key' as the key
        plain_text_array = VigenereUtil.text_to_array(plain_text)
        split_key = VigenereUtil.text_to_array(key)
        numeric_encoded_plain_text = []
        k = 0
        for i in 0..plain_text_array.length-1
            k_i = VigenereUtil.letter_to_number(split_key[k])
            x = (VigenereUtil.letter_to_number(plain_text_array[i]) + k_i) % 26
            numeric_encoded_plain_text[i] = x
            k += 1
            if (k >= key.length) then
                k = 0
            end
        end
        encoded_plain_text = numeric_encoded_plain_text.map { |x| VigenereUtil.number_to_letter(x) }
        # Original:
        p(plain_text)
        # Trimmed
        p(plain_text_array)
        # Encoded:
        p(encoded_plain_text)
        @cipher_text = encoded_plain_text.join('')
    end

    def decrypt(key)
        @cipher_text#.map { |x| VigenereUtil.number_to_letter(VigenereUtil.letter_to_number(x)) }
    end

    def brute_force_known_substr(substr, key_length)
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
    end
end