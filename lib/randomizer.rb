$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Randomizer
  VERSION = '0.0.1'
end

class Array
  def random
    self[Kernel.rand(size)]
  end
end

DB_DIR = File.join(File.dirname(__FILE__), '..', 'data')

require 'randomizer/all_avatars_site'
require 'randomizer/random_user'
require 'randomizer/name_generator'
require 'randomizer/markov_text_generator'
