# VigenereBrute.rb
# ruby 2.6.6p146 (2020-03-31 revision 67876) [x64-mingw32]

require_relative 'Vigenere.rb'
require 'workers'

class VigenereBrute
    def initialize
        @possible_plaintexts = []
    end

    def brute_force_known_substr(cipher_text, plain_substr, key_length)
        keys = join_key( key_gen( key_length ), key_length )
        vig = Vigenere.new
        pool = Workers::Pool.new(:on_exception => proc { |e|
          puts "A worker encountered an exception: #{e.class}: #{e.message}"
        })
        # create a task group
        group = Workers::TaskGroup.new(:pool => pool)
        keys.each do |key|
            group.add do
                pt = vig.decrypt( cipher_text, key )
                if (pt.include?( plain_substr )) then
                    begin
                        group.synchronize(
                            begin
                                @possible_plaintexts.push( {:plaintext => pt, :key => key} )
                                puts( "Found: \"" + pt + "\" with key: \"" + key + "\", continue? ")
                                readline
                            end
                        )
                    rescue
                    end
                    raise 'Found'
                end
                [pt, key]
            end
        end
        # run group of tasks
        group.run
        p group.tasks.length
        p group.successes.length
        # get results
        @possible_plaintexts.each do |pt|
            p pt
        end
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

