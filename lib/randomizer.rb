class Array
  def random
    self[Kernel.rand(size)]
  end
end

DB_DIR = File.join(File.dirname(__FILE__), '..', 'data')


%w(all_avatars_site random_user name_generator markov_text_generator).each do |file|
  require File.join(File.dirname(__FILE__), 'randomizer', file)
end

