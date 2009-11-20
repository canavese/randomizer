class NameGenerator

  def self.instance
    @@instance ||= NameGenerator.new
  end

  def initialize
    @female_first_names = parse_name_file('female_first_names.txt') # Top 500 female names.
    @male_first_names = parse_name_file('male_first_names.txt') # Top 500 male names.
    @last_names = parse_name_file('last_names.txt') # Top 3000 last names.
    @first_names = @female_first_names + @male_first_names
  end

  def parse_name_file(filename)
    File.readlines(File.join(DB_DIR, filename)).collect {|line| line.strip}
  end

  def random(options = {})
    [random_first_name(options), random_last_name(options)]
  end  

  def random_first_name(options = {})
    case options[:gender]
      when 'm', 'male' then @male_first_names.random
      when 'f', 'female' then @female_first_names.random
      else @first_names.random
    end
  end

  def random_last_name(options = {})
    @last_names.random
  end

end