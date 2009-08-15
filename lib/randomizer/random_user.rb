PASSWORD_CHARACTERS = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
EMAIL_DOMAINS = %w{gmail.com hotmail.com aol.com aim.com yahoo.com msn.com comcast.net sbcglobal.net bellsouth.net verizon.net earthlink.net cox.net rediffmail.com charter.net ntlworld.com}

class RandomUser
  attr_reader :first_name, :last_name

  def initialize
    names = NameGenerator.instance.random
    @first_name = names.first
    @last_name = names.last
  end

  def full_name
    @full_name ||= [@first_name, @last_name].join(' ')
  end

  #
  # AVATAR
  #

  def avatar_url
    @avatar_url ||= AllAvatarsSite.instance.random_url
  end

  #
  # PASSWORD
  #

  def password
    @password ||= random_password
  end

  def random_password
    Array.new(8, '').collect{PASSWORD_CHARACTERS.random}.join
  end

  #
  # NICKNAME
  #

  def nickname
    @nickname || regenerate_nickname
  end

  def regenerate_nickname
    @nickname = random_nickname
  end

  def random_nickname
    RandomUser.nicknames(@first_name, @last_name).random
  end

  def self.nicknames(first, last)
    first, last = first.downcase, last.downcase
    [first, last, first[0..0] + last, first + last[0..0], first + last, first + '2', first + '3']
  end

  #
  # EMAIL ADDRESS
  #

  def email
    @email || regenerate_email
  end

  def regenerate_email
    @email = random_nickname + '@' + random_email_domain
  end

  def random_email_domain
    EMAIL_DOMAINS.random
  end

end