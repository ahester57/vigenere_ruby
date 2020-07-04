# TestVigenere.rb
# ruby 2.6.6p146 (2020-03-31 revision 67876) [x64-mingw32]
#
require_relative 'Vigenere.rb'
require 'test/unit'

class TestVigenere < Test::Unit::TestCase
 
    def setup
        @v = Vigenere.new
        @plain_text_list = []
        puts( "Input Range" )
        for i in 0..25
            p @plain_text_list[i] = (0...60).map { ( 49 + rand(68) ).chr }.join
        end
    end

    def test_vigenere()
        #for i in 0..@plain_text_list[i]-1
        @plain_text_list.each do |pt|
            k = (0..8).map { ( 97 + rand(26) ).chr }.join
            trimmed_input = VigenereUtil.text_to_array(pt).join
            cipher_text = @v.encrypt( pt, k )
            decoded_input = @v.decrypt( cipher_text, k )
            puts( "key:\t\t" + k ) 
            puts( "trimmed_input:\t" + trimmed_input ) 
            puts( "cipher:\t\t" + cipher_text )
            puts( "decoded_input:\t" + decoded_input )
            assert_equal(
                trimmed_input,
                decoded_input
            )
        end
    end

end
