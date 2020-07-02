# Vigenere.rb
# ruby 2.6.6p146 (2020-03-31 revision 67876) [x64-mingw32]

class Vigenere
    attr_accessor(:key, :plain_text)

    def initialize(plain_text)
        @plain_text = plain_text
        @cipher_text = nil
    end

    def encrypt(key)
        @cipher_text = plain_text.downcase.chars.reject { |x| !VigenereUtil.letter?(x) }
    end

    def decrypt_with_key(key)
        @cipher_text.join('')
    end

    def decrypt_with_known_plain_text_key_length(substring, key_length)
        "TBD"
    end

end

class VigenereUtil
    # the next line is an 'Eigenclass', which simulates static methods in Ruby
    # src: http://nicholasjohnson.com/ruby/ruby-course/exercises/static-methods/
    class << VigenereUtil
        # src: https://stackoverflow.com/questions/14551256/ruby-how-to-find-out-if-a-character-is-a-letter-or-a-digit
        def letter?(lookAhead)
            lookAhead =~ /[[:alpha:]]/
        end
        def digit?(lookAhead)
            lookAhead =~ /[[:digit:]]/
        end
    end
end