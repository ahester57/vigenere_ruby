# VigenereBrute.rb
# ruby 2.6.6p146 (2020-03-31 revision 67876) [x64-mingw32]

require_relative 'Vigenere.rb'
require 'workers'

class VigenereBrute

    def brute_force_known_substr(cipher_text, plain_substr, key_length)
        keys = join_key( key_gen( key_length ), key_length )
        p keys
    end

    private def join_key(keys, key_length)
        if (key_length == 1) then
            return keys 
        end
        keys.map { |x| x.join }
    end

    private def key_gen(key_length)
        chars = [*'a'..'z']
        if (key_length == 1) then
            return chars = [*'a'..'z']
        end
        chars.product( key_gen( key_length - 1) )
    end
end

