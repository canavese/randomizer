# Adapted from the famous shaney.py by Greg McFarlane

#DEFAULT_SOURCE_TEXT = File.readlines(File.join(DB_DIR, 'text', 'alice_in_wonderland.txt')).join
#DEFAULT_SOURCE_TEXT = File.readlines(File.join(DB_DIR, 'text', 'the_wall_street_girl.txt')).join
#DEFAULT_SOURCE_TEXT = File.readlines(File.join(DB_DIR, 'text', 'the_adventures_of_sherlock_holmes.txt')).join
#DEFAULT_SOURCE_TEXT = File.readlines(File.join(DB_DIR, 'text', 'lorem_ipsum.txt')).join
DEFAULT_SOURCE_TEXT = File.readlines(File.join(DB_DIR, 'text', 'aesop.txt')).join

class MarkovTextGenerator
  
  def self.instance
    @@instance ||= MarkovTextGenerator.new
  end

  def initialize(text = DEFAULT_SOURCE_TEXT)
    text = remove_gutenberg_text(text)
    words = text.split

    @end_sentence = []
    @dict = {}
    prev1 = ''
    prev2 = ''
    for word in words
      if prev1 != '' && prev2 != ''
        key = [prev2, prev1]
        if @dict.key?(key):
          @dict[key] << word
        else
          @dict[key] = [word]
          @end_sentence << key if prev1[-1, 1] == '.'
        end
      end
      prev2 = prev1
      prev1 = word
    end

    raise 'Sorry, there are no sentences in the text.' if @end_sentence.empty?

    true
  end

  def remove_gutenberg_text(text)
    text = text.sub(/^.*[*]{3} START OF THIS PROJECT GUTENBERG .*? [*]{3}/m, '')
    text = text.sub(/End of the Project Gutenberg.*$/im, '')
    text = text.sub(/End of Project Gutenberg.*$/im, '')
    text = text.gsub(/(\n|\r)[A-Z '"]+(\n|\r)/m, '')
    text = text.gsub(/_/, '')
    text = text.gsub(/\[Illustration.*?\]/, '')
  end

  def random(sentence_count = 10)
    results = []
    key = nil

    while true
      if @dict.key?(key)
        word = @dict[key].random
        results << word
        key = [key.last, word]
        if @end_sentence.include?(key)
          results << ''
          sentence_count -= 1
          break if sentence_count <= 0
        end
      else
        key = @end_sentence.random
      end
    end

    results.join(' ')
  end 

end