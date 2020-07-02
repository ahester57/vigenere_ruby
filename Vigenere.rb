# Vigenere.rb
class Vigenere
    attr_accessor(:key, :plain_text)

    def initialize(plain_text)
        @plain_text = plain_text
        @cipher_text = nil
    end

    def encrypt(key)
        @cipher_text = plain_text.upcase
    end

    def decrypt_with_key(key)
        @cipher_text.downcase
    end

    def decrypt_with_known_plain_text_key_length(substring, key_length)
        "TBD"
    end
end